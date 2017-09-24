#------------------------------------------------------------------------------
# File:         XMP2.pl
#
# Description:  Additional XMP namespace definitions
#
# Revisions:    10/12/2008 - P. Harvey Created
#
# References:   1) PLUS - http://ns.useplus.org/
#               2) PRISM - http://www.prismstandard.org/
#               3) http://www.portfoliofaq.com/pfaq/v7mappings.htm
#               4) http://www.iptc.org/IPTC4XMP/
#               5) http://creativecommons.org/technology/xmp
#                  --> changed to http://wiki.creativecommons.org/Companion_File_metadata_specification (2007/12/21)
#               6) http://www.optimasc.com/products/fileid/xmp-extensions.pdf
#               9) http://www.w3.org/TR/SVG11/
#               11) http://www.extensis.com/en/support/kb_article.jsp?articleNumber=6102211
#               12) XMPSpecificationPart3_May2013, page 58
#------------------------------------------------------------------------------

package Image::ExifTool::XMP;

use strict;
use Image::ExifTool qw(:Utils);
use Image::ExifTool::XMP;

#------------------------------------------------------------------------------

# xmpDM structure definitions
my %sCuePointParam = (
    STRUCT_NAME => 'CuePointParam',
    NAMESPACE   => 'xmpDM',
    key         => { },
    value       => { },
);
my %sMarker = (
    STRUCT_NAME => 'Marker',
    NAMESPACE   => 'xmpDM',
    comment     => { },
    duration    => { },
    location    => { },
    name        => { },
    startTime   => { },
    target      => { },
    type        => { },
    # added Oct 2008
    cuePointParams => { Struct => \%sCuePointParam, List => 'Seq' },
    cuePointType=> { },
    probability => { Writable => 'real' },
    speaker     => { },
);
my %sTime = (
    STRUCT_NAME => 'Time',
    NAMESPACE   => 'xmpDM',
    scale       => { Writable => 'rational' },
    value       => { Writable => 'integer' },
);
my %sTimecode = (
    STRUCT_NAME => 'Timecode',
    NAMESPACE   => 'xmpDM',
    timeFormat  => {
        PrintConv => {
            '24Timecode' => '24 fps',
            '25Timecode' => '25 fps',
            '2997DropTimecode' => '29.97 fps (drop)',
            '2997NonDropTimecode' => '29.97 fps (non-drop)',
            '30Timecode' => '30 fps',
            '50Timecode' => '50 fps',
            '5994DropTimecode' => '59.94 fps (drop)',
            '5994NonDropTimecode' => '59.94 fps (non-drop)',
            '60Timecode' => '60 fps',
            '23976Timecode' => '23.976 fps',
        },
    },
    timeValue   => { },
    value       => { Writable => 'integer' },
);

# XMP Dynamic Media namespace properties (xmpDM)
%Image::ExifTool::XMP::xmpDM = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-xmpDM', 2 => 'Image' },
    NAMESPACE => 'xmpDM',
    NOTES => 'XMP Dynamic Media namespace tags.',
    absPeakAudioFilePath=> { },
    album               => { },
    altTapeName         => { },
    altTimecode         => { Struct => \%sTimecode },
    artist              => { Avoid => 1, Groups => { 2 => 'Author' } },
    audioModDate        => { Groups => { 2 => 'Time' }, %dateTimeInfo },
    audioSampleRate     => { Writable => 'integer' },
    audioSampleType => {
        PrintConv => {
            '8Int' => '8-bit integer',
            '16Int' => '16-bit integer',
            '24Int' => '24-bit integer',
            '32Int' => '32-bit integer',
            '32Float' => '32-bit float',
            'Compressed' => 'Compressed',
            'Packed' => 'Packed',
            'Other' => 'Other',
        },
    },
    audioChannelType => {
        PrintConv => {
            'Mono' => 'Mono',
            'Stereo' => 'Stereo',
            '5.1' => '5.1',
            '7.1' => '7.1',
            '16 Channel' => '16 Channel',
            'Other' => 'Other',
        },
    },
    audioCompressor     => { },
    beatSpliceParams => {
        Struct => {
            STRUCT_NAME => 'BeatSpliceStretch',
            NAMESPACE   => 'xmpDM',
            riseInDecibel       => { Writable => 'real' },
            riseInTimeDuration  => { Struct => \%sTime },
            useFileBeatsMarker  => { Writable => 'boolean' },
        },
    },
    cameraAngle         => { },
    cameraLabel         => { },
    cameraModel         => { },
    cameraMove          => { },
    client              => { },
    comment             => { Name => 'DMComment' },
    composer            => { Groups => { 2 => 'Author' } },
    contributedMedia => {
        Struct => {
            STRUCT_NAME => 'Media',
            NAMESPACE   => 'xmpDM',
            duration    => { Struct => \%sTime },
            managed     => { Writable => 'boolean' },
            path        => { },
            startTime   => { Struct => \%sTime },
            track       => { },
            webStatement=> { },
        },
        List => 'Bag',
    },
    copyright       => { Avoid => 1, Groups => { 2 => 'Author' } }, # (deprecated)
    director        => { },
    directorPhotography => { },
    discNumber      => { }, #12
    duration        => { Struct => \%sTime },
    engineer        => { },
    fileDataRate    => { Writable => 'rational' },
    genre           => { },
    good            => { Writable => 'boolean' },
    instrument      => { },
    introTime       => { Struct => \%sTime },
    key => {
        PrintConvColumns => 3,
        PrintConv => {
            'C'  => 'C',  'C#' => 'C#', 'D'  => 'D',  'D#' => 'D#',
            'E'  => 'E',  'F'  => 'F',  'F#' => 'F#', 'G'  => 'G',
            'G#' => 'G#', 'A'  => 'A',  'A#' => 'A#', 'B'  => 'B',
        },
    },
    logComment      => { },
    loop            => { Writable => 'boolean' },
    lyrics          => { }, #12
    numberOfBeats   => { Writable => 'real' },
    markers         => { Struct => \%sMarker, List => 'Seq' },
    metadataModDate => { Groups => { 2 => 'Time' }, %dateTimeInfo },
    outCue          => { Struct => \%sTime },
    partOfCompilation=>{ Writable => 'boolean' }, #12
    projectName     => { },
    projectRef => {
        Struct => {
            STRUCT_NAME => 'ProjectLink',
            NAMESPACE   => 'xmpDM',
            path        => { },
            type        => {
                PrintConv => {
                    movie => 'Movie',
                    still => 'Still Image',
                    audio => 'Audio',
                    custom => 'Custom',
                },
            },
        },
    },
    pullDown => {
        PrintConvColumns => 2,
        PrintConv => {
            'WSSWW' => 'WSSWW',  'SSWWW' => 'SSWWW',
            'SWWWS' => 'SWWWS',  'WWWSS' => 'WWWSS',
            'WWSSW' => 'WWSSW',  'WWWSW' => 'WWWSW',
            'WWSWW' => 'WWSWW',  'WSWWW' => 'WSWWW',
            'SWWWW' => 'SWWWW',  'WWWWS' => 'WWWWS',
        },
    },
    relativePeakAudioFilePath => { },
    relativeTimestamp   => { Struct => \%sTime },
    releaseDate         => { Groups => { 2 => 'Time' }, %dateTimeInfo },
    resampleParams => {
        Struct => {
            STRUCT_NAME => 'ResampleStretch',
            NAMESPACE   => 'xmpDM',
            quality     => { PrintConv => { Low => 'Low', Medium => 'Medium', High => 'High' } },
        },
    },
    scaleType => {
        PrintConv => {
            Major => 'Major',
            Minor => 'Minor',
            Both => 'Both',
            Neither => 'Neither',
        },
    },
    scene           => { Avoid => 1 },
    shotDate        => { Groups => { 2 => 'Time' }, %dateTimeInfo },
    shotDay         => { },
    shotLocation    => { },
    shotName        => { },
    shotNumber      => { },
    shotSize        => { },
    speakerPlacement=> { },
    startTimecode   => { Struct => \%sTimecode },
    startTimeSampleSize => { Writable => 'integer' }, #PH
    startTimeScale  => { }, #PH (real?)
    stretchMode     => {
        PrintConv => {
            'Fixed length' => 'Fixed length',
            'Time-Scale' => 'Time-Scale',
            'Resample' => 'Resample',
            'Beat Splice' => 'Beat Splice',
            'Hybrid' => 'Hybrid',
        },
    },
    takeNumber      => { Writable => 'integer' },
    tapeName        => { },
    tempo           => { Writable => 'real' },
    timeScaleParams => {
        Struct => {
            STRUCT_NAME => 'TimeScaleStretch',
            NAMESPACE   => 'xmpDM',
            frameOverlappingPercentage => { Writable => 'real' },
            frameSize   => { Writable => 'real' },
            quality     => { PrintConv => { Low => 'Low', Medium => 'Medium', High => 'High' } },
        },
    },
    timeSignature   => {
        PrintConvColumns => 3,
        PrintConv => {
            '2/4' => '2/4',  '3/4' => '3/4',  '4/4' => '4/4',
            '5/4' => '5/4',  '7/4' => '7/4',  '6/8' => '6/8',
            '9/8' => '9/8',  '12/8'=> '12/8', 'other' => 'other',
        },
    },
    trackNumber     => { Writable => 'integer' },
    Tracks => {
        Struct => {
            STRUCT_NAME => 'Track',
            NAMESPACE   => 'xmpDM',
            frameRate => { },
            markers   => { Struct => \%sMarker, List => 'Seq' },
            trackName => { },
            trackType => { },
        },
        List => 'Bag',
    },
    videoAlphaMode => {
        PrintConv => {
            'straight' => 'Straight',
            'pre-multiplied', => 'Pre-multiplied',
            'none' => 'None',
        },
    },
    videoAlphaPremultipleColor   => { Struct => \%sColorant },
    videoAlphaUnityIsTransparent => { Writable => 'boolean' },
    videoColorSpace     => {
        PrintConv => {
            'sRGB' => 'sRGB',
            'CCIR-601' => 'CCIR-601',
            'CCIR-709' => 'CCIR-709',
        },
    },
    videoCompressor => { },
    videoFieldOrder => {
        PrintConv => {
            Upper => 'Upper',
            Lower => 'Lower',
            Progressive => 'Progressive',
        },
    },
    videoFrameRate  => { Writable => 'real' },
    videoFrameSize  => { Struct => \%sDimensions },
    videoModDate    => { Groups => { 2 => 'Time' }, %dateTimeInfo },
    videoPixelAspectRatio => { Writable => 'rational' },
    videoPixelDepth => {
        PrintConv => {
            '8Int' => '8-bit integer',
            '16Int' => '16-bit integer',
            '24Int' => '24-bit integer',
            '32Int' => '32-bit integer',
            '32Float' => '32-bit float',
            'Other' => 'Other',
        },
    },
);

#------------------------------------------------------------------------------
# IPTC Extensions version 1.3 (+ proposed video extensions)

# IPTC Extension 1.0 structures
my %sLocationDetails = (
    STRUCT_NAME => 'LocationDetails',
    NAMESPACE   => 'Iptc4xmpExt',
    GROUPS      => { 2 => 'Location' },
    Identifier  => { List => 'Bag', Namespace => 'xmp' },
    City        => { },
    CountryCode => { },
    CountryName => { },
    ProvinceState => { },
    Sublocation => { },
    WorldRegion => { },
    LocationId  => { List => 'Bag' },
    LocationName => { Writable => 'lang-alt' },
    GPSLatitude  => { Namespace => 'exif', %latConv },
    GPSLongitude => { Namespace => 'exif', %longConv },
    GPSAltitude => {
        Namespace => 'exif',
        Writable => 'rational',
        PrintConv => '$val =~ /^(inf|undef)$/ ? $val : "$val m"',
        PrintConvInv => '$val=~s/\s*m$//;$val',
    },
);
my %sCVTermDetails = (
    STRUCT_NAME => 'CVTermDetails',
    NAMESPACE   => 'Iptc4xmpExt',
    CvTermId    => { },
    CvTermName  => { Writable => 'lang-alt' },
    CvId        => { },
    CvTermRefinedAbout => { },
);

# IPTC video extensions
my %sPublicationEvent = (
    STRUCT_NAME => 'PublicationEvent',
    NAMESPACE   => 'Iptc4xmpExt',
    Date        => { Groups => { 2 => 'Time' }, %dateTimeInfo },
    Name        => { },
    Identifier  => { },
);
my %sEntity = (
    STRUCT_NAME => 'Entity',
    NAMESPACE   => 'Iptc4xmpExt',
    Identifier  => { List => 'Bag', Namespace => 'xmp' },
    Name        => { Writable => 'lang-alt' },
);
my %sEntityWithRole = (
    STRUCT_NAME => 'EntityWithRole',
    NAMESPACE   => 'Iptc4xmpExt',
    Identifier  => { List => 'Bag', Namespace => 'xmp' },
    Name        => { Writable => 'lang-alt' },
    Role        => { List => 'Bag' },
);
my %sFrameSize = (
    STRUCT_NAME => 'FrameSize',
    NAMESPACE   => 'Iptc4xmpExt',
    WidthPixels  => { Writable => 'integer' },
    HeightPixels => { Writable => 'integer' },
);
my %sRating = (
    STRUCT_NAME => 'Rating',
    NAMESPACE   => 'Iptc4xmpExt',
    RatingValue         => { FlatName => 'Value' },
    RatingSourceLink    => { FlatName => 'SourceLink' },
    RatingScaleMinValue => { FlatName => 'ScaleMinValue' },
    RatingScaleMaxValue => { FlatName => 'ScaleMaxValue' },
    RatingValueLogoLink => { FlatName => 'ValueLogoLink' },
    RatingRegion => {
        FlatName => 'RatingRegion',
        Struct => \%sLocationDetails,
        List => 'Bag',
    },
);
my %sEpisode = (
    STRUCT_NAME => 'EpisodeOrSeason',
    NAMESPACE   => 'Iptc4xmpExt',
    Name        => { },
    Number      => { },
    Identifier  => { },
);
my %sSeries = (
    STRUCT_NAME => 'Series',
    NAMESPACE   => 'Iptc4xmpExt',
    Name        => { },
    Identifier  => { },
);
my %sTemporalCoverage = (
    STRUCT_NAME => 'TemporalCoverage',
    NAMESPACE   => 'Iptc4xmpExt',
    tempCoverageFrom => { FlatName => 'From', %dateTimeInfo, Groups => { 2 => 'Time' } },
    tempCoverageTo   => { FlatName => 'To',   %dateTimeInfo, Groups => { 2 => 'Time' } },
);
my %sQualifiedLink = (
    STRUCT_NAME => 'QualifiedLink',
    NAMESPACE   => 'Iptc4xmpExt',
    Link        => { },
    LinkQualifier => { },
);
my %sTextRegion = (
    STRUCT_NAME => 'TextRegion',
    NAMESPACE   => 'Iptc4xmpExt',
    RegionText  => { },
    Region      => { Struct => \%Image::ExifTool::XMP::sArea },
);
my %sLinkedImage = (
    STRUCT_NAME => 'LinkedImage',
    NAMESPACE   => 'Iptc4xmpExt',
    Link        => { },
    LinkQualifier => { List => 'Bag' },
    ImageRole   => { },
   'format'     => { Namespace => 'dc' },
    WidthPixels => { Writable => 'integer' },
    HeightPixels=> { Writable => 'integer' },
    UsedVideoFrame => { Struct => \%sTimecode },
);

# IPTC Extension namespace properties (Iptc4xmpExt) (ref 4)
%Image::ExifTool::XMP::iptcExt = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-iptcExt', 2 => 'Author' },
    NAMESPACE   => 'Iptc4xmpExt',
    TABLE_DESC => 'XMP IPTC Extension',
    NOTES => q{
        IPTC Extension namespace tags.  The actual namespace prefix is
        "Iptc4xmpExt", but ExifTool shortens this for the family 1 group name. (see
        L<http://www.iptc.org/IPTC4XMP/>)
    },
    AboutCvTerm => {
        Struct => \%sCVTermDetails,
        List => 'Bag',
    },
    AboutCvTermCvId                 => { Flat => 1, Name => 'AboutCvTermCvId' },
    AboutCvTermCvTermId             => { Flat => 1, Name => 'AboutCvTermId' },
    AboutCvTermCvTermName           => { Flat => 1, Name => 'AboutCvTermName' },
    AboutCvTermCvTermRefinedAbout   => { Flat => 1, Name => 'AboutCvTermRefinedAbout' },
    AddlModelInfo   => { Name => 'AdditionalModelInformation' },
    ArtworkOrObject => {
        Struct => {
            STRUCT_NAME => 'ArtworkOrObjectDetails',
            NAMESPACE   => 'Iptc4xmpExt',
            AOCopyrightNotice => { },
            AOCreator    => { List => 'Seq' },
            AODateCreated=> { Groups => { 2 => 'Time' }, %dateTimeInfo },
            AOSource     => { },
            AOSourceInvNo=> { },
            AOTitle      => { Writable => 'lang-alt' },
            AOCurrentCopyrightOwnerName => { },
            AOCurrentCopyrightOwnerId   => { },
            AOCurrentLicensorName       => { },
            AOCurrentLicensorId         => { },
            AOCreatorId                 => { List => 'Seq' },
            AOCircaDateCreated          => { Groups => { 2 => 'Time' } },
            AOStylePeriod               => { List => 'Bag' },
            AOSourceInvURL              => { },
            AOContentDescription        => { Writable => 'lang-alt' },
            AOContributionDescription   => { Writable => 'lang-alt' },
            AOPhysicalDescription       => { Writable => 'lang-alt' },
        },
        List => 'Bag',
    },
    ArtworkOrObjectAOCopyrightNotice           => { Flat => 1, Name => 'ArtworkCopyrightNotice' },
    ArtworkOrObjectAOCreator                   => { Flat => 1, Name => 'ArtworkCreator' },
    ArtworkOrObjectAODateCreated               => { Flat => 1, Name => 'ArtworkDateCreated' },
    ArtworkOrObjectAOSource                    => { Flat => 1, Name => 'ArtworkSource' },
    ArtworkOrObjectAOSourceInvNo               => { Flat => 1, Name => 'ArtworkSourceInventoryNo' },
    ArtworkOrObjectAOTitle                     => { Flat => 1, Name => 'ArtworkTitle' },
    ArtworkOrObjectAOCurrentCopyrightOwnerName => { Flat => 1, Name => 'ArtworkCopyrightOwnerName' },
    ArtworkOrObjectAOCurrentCopyrightOwnerId   => { Flat => 1, Name => 'ArtworkCopyrightOwnerID' },
    ArtworkOrObjectAOCurrentLicensorName       => { Flat => 1, Name => 'ArtworkLicensorName' },
    ArtworkOrObjectAOCurrentLicensorId         => { Flat => 1, Name => 'ArtworkLicensorID' },
    ArtworkOrObjectAOCreatorId                 => { Flat => 1, Name => 'ArtworkCreatorID' },
    ArtworkOrObjectAOCircaDateCreated          => { Flat => 1, Name => 'ArtworkCircaDateCreated' },
    ArtworkOrObjectAOStylePeriod               => { Flat => 1, Name => 'ArtworkStylePeriod' },
    ArtworkOrObjectAOSourceInvURL              => { Flat => 1, Name => 'ArtworkSourceInvURL' },
    ArtworkOrObjectAOContentDescription        => { Flat => 1, Name => 'ArtworkContentDescription' },
    ArtworkOrObjectAOContributionDescription   => { Flat => 1, Name => 'ArtworkContributionDescription' },
    ArtworkOrObjectAOPhysicalDescription       => { Flat => 1, Name => 'ArtworkPhysicalDescription' },
    CVterm => {
        Name => 'ControlledVocabularyTerm',
        List => 'Bag',
        Notes => 'deprecated by version 1.2',
    },
    DigImageGUID            => { Name => 'DigitalImageGUID' },
    DigitalSourcefileType   => {
        Name => 'DigitalSourceFileType',
        Notes => 'now deprecated -- replaced by DigitalSourceType',
    },
    DigitalSourceType       => { Name => 'DigitalSourceType' },
    EmbdEncRightsExpr => {
        Struct => {
            STRUCT_NAME => 'EEREDetails',
            NAMESPACE   => 'Iptc4xmpExt',
            EncRightsExpr       => { },
            RightsExprEncType   => { },
            RightsExprLangId    => { },
        },
        List => 'Bag',
    },
    EmbdEncRightsExprEncRightsExpr      => { Flat => 1, Name => 'EmbeddedEncodedRightsExpr' },
    EmbdEncRightsExprRightsExprEncType  => { Flat => 1, Name => 'EmbeddedEncodedRightsExprType' },
    EmbdEncRightsExprRightsExprLangId   => { Flat => 1, Name => 'EmbeddedEncodedRightsExprLangID' },
    Event       => { Writable => 'lang-alt' },
    IptcLastEdited => {
        Name => 'IPTCLastEdited',
        Groups => { 2 => 'Time' },
        %dateTimeInfo,
    },
    LinkedEncRightsExpr => {
        Struct => {
            STRUCT_NAME => 'LEREDetails',
            NAMESPACE   => 'Iptc4xmpExt',
            LinkedRightsExpr    => { },
            RightsExprEncType   => { },
            RightsExprLangId    => { },
        },
        List => 'Bag',
    },
    LinkedEncRightsExprLinkedRightsExpr  => { Flat => 1, Name => 'LinkedEncodedRightsExpr' },
    LinkedEncRightsExprRightsExprEncType => { Flat => 1, Name => 'LinkedEncodedRightsExprType' },
    LinkedEncRightsExprRightsExprLangId  => { Flat => 1, Name => 'LinkedEncodedRightsExprLangID' },
    LocationCreated => {
        Struct => \%sLocationDetails,
        Groups => { 2 => 'Location' },
        List => 'Bag',
    },
    LocationShown => {
        Struct => \%sLocationDetails,
        Groups => { 2 => 'Location' },
        List => 'Bag',
    },
    MaxAvailHeight          => { Writable => 'integer' },
    MaxAvailWidth           => { Writable => 'integer' },
    ModelAge                => { List => 'Bag', Writable => 'integer' },
    OrganisationInImageCode => { List => 'Bag' },
    OrganisationInImageName => { List => 'Bag' },
    PersonInImage           => { List => 'Bag' },
    PersonInImageWDetails => {
        Struct => {
            STRUCT_NAME => 'PersonDetails',
            NAMESPACE   => 'Iptc4xmpExt',
            PersonId    => { List => 'Bag' },
            PersonName  => { Writable => 'lang-alt' },
            PersonCharacteristic => {
                Struct  => \%sCVTermDetails,
                List    => 'Bag',
            },
            PersonDescription => { Writable => 'lang-alt' },
        },
        List => 'Bag',
    },
    PersonInImageWDetailsPersonId                               => { Flat => 1, Name => 'PersonInImageId' },
    PersonInImageWDetailsPersonName                             => { Flat => 1, Name => 'PersonInImageName' },
    PersonInImageWDetailsPersonCharacteristic                   => { Flat => 1, Name => 'PersonInImageCharacteristic' },
    PersonInImageWDetailsPersonCharacteristicCvId               => { Flat => 1, Name => 'PersonInImageCvTermCvId' },
    PersonInImageWDetailsPersonCharacteristicCvTermId           => { Flat => 1, Name => 'PersonInImageCvTermId' },
    PersonInImageWDetailsPersonCharacteristicCvTermName         => { Flat => 1, Name => 'PersonInImageCvTermName' },
    PersonInImageWDetailsPersonCharacteristicCvTermRefinedAbout => { Flat => 1, Name => 'PersonInImageCvTermRefinedAbout' },
    PersonInImageWDetailsPersonDescription                      => { Flat => 1, Name => 'PersonInImageDescription' },
    ProductInImage => {
        Struct => {
            STRUCT_NAME => 'ProductDetails',
            NAMESPACE   => 'Iptc4xmpExt',
            ProductName => { Writable => 'lang-alt' },
            ProductGTIN => { },
            ProductDescription => { Writable => 'lang-alt' },
        },
        List => 'Bag',
    },
    ProductInImageProductName        => { Flat => 1, Name => 'ProductInImageName' },
    ProductInImageProductGTIN        => { Flat => 1, Name => 'ProductInImageGTIN' },
    ProductInImageProductDescription => { Flat => 1, Name => 'ProductInImageDescription' },
    RegistryId => {
        Name => 'RegistryID',
        Struct => {
            STRUCT_NAME => 'RegistryEntryDetails',
            NAMESPACE   => 'Iptc4xmpExt',
            RegItemId   => { },
            RegOrgId    => { },
            RegEntryRole=> { }, # (new in 1.3)
        },
        List => 'Bag',
    },
    RegistryIdRegItemId => { Flat => 1, Name => 'RegistryItemID' },
    RegistryIdRegOrgId  => { Flat => 1, Name => 'RegistryOrganisationID' },
    RegistryIdRegEntryRole => { Flat => 1, Name => 'RegistryEntryRole' },

    # new Extension 1.3 properties
    Genre           => { Groups => { 2 => 'Image' }, List => 'Bag', Struct => \%sCVTermDetails },

    # new video properties (Oct 2016, ref Michael Steidl)
    # (see http://www.iptc.org/std/videometadatahub/recommendation/IPTC-VideoMetadataHub-props-Rec_1.0.html)
    CircaDateCreated=> { Groups => { 2 => 'Time' } },
    Episode         => { Groups => { 2 => 'Video' }, Struct => \%sEpisode },
    ExternalMetadataLink => { Groups => { 2 => 'Other' }, List => 'Bag' },
    FeedIdentifier  => { Groups => { 2 => 'Video' } },
    PublicationEvent=> { Groups => { 2 => 'Video' }, List => 'Bag', Struct => \%sPublicationEvent },
    Rating          => {
        Groups => { 2 => 'Other' },
        Struct  => \%sRating,
        List    => 'Bag',
    },
    ReleaseReady    => { Groups => { 2 => 'Other' }, Writable => 'boolean' },
    Season          => { Groups => { 2 => 'Video' }, Struct => \%sEpisode },
    Series          => { Groups => { 2 => 'Video' }, Struct => \%sSeries },
    StorylineIdentifier => { Groups => { 2 => 'Video' }, List => 'Bag' },
    StylePeriod     => { Groups => { 2 => 'Video' } },
    TemporalCoverage=> { Groups => { 2 => 'Video' }, Struct => \%sTemporalCoverage },
    WorkflowTag     => { Groups => { 2 => 'Video' }, Struct => \%sCVTermDetails },
    DataOnScreen    => { Groups => { 2 => 'Video' }, List => 'Bag', Struct => \%sTextRegion },
    Dopesheet       => { Groups => { 2 => 'Video' }, Writable => 'lang-alt' },
    DopesheetLink   => { Groups => { 2 => 'Video' }, List => 'Bag', Struct => \%sQualifiedLink },
    Headline        => { Groups => { 2 => 'Video' }, Writable => 'lang-alt', Avoid => 1 },
    PersonHeard     => { Groups => { 2 => 'Audio' }, List => 'Bag', Struct => \%sEntity },
    VideoShotType   => { Groups => { 2 => 'Video' }, List => 'Bag', Struct => \%sEntity },
    EventExt        => { Groups => { 2 => 'Video' }, List => 'Bag', Struct => \%sEntity, Name => 'ShownEvent' },
    Transcript      => { Groups => { 2 => 'Video' }, Writable => 'lang-alt' },
    TranscriptLink  => { Groups => { 2 => 'Video' }, List => 'Bag', Struct => \%sQualifiedLink },
    VisualColour    => {
        Name => 'VisualColor',
        Groups => { 2 => 'Video' },
        PrintConv => {
            'bw-monochrome' => 'Monochrome',
            'colour'        => 'Color',
        },
    },
    Contributor     => { List => 'Bag', Struct => \%sEntityWithRole },
    CopyrightYear   => { Groups => { 2 => 'Time' },  Writable => 'integer' },
    Creator         => { List => 'Bag', Struct => \%sEntityWithRole },
    SupplyChainSource => { Groups => { 2 => 'Other' }, List => 'Bag', Struct => \%sEntity },
    audioBitRate    => { Groups => { 2 => 'Audio' }, Writable => 'integer', Name => 'AudioBitrate' },
    audioBitRateMode=> {
        Name => 'AudioBitrateMode',
        Groups => { 2 => 'Audio' },
        PrintConv => {
            fixed => 'Fixed',
            variable => 'Variable',
        },
    },
    audioChannelCount       => { Groups => { 2 => 'Audio' }, Writable => 'integer' },
    videoDisplayAspectRatio => { Groups => { 2 => 'Audio' }, Writable => 'rational' },
    ContainerFormat         => { Groups => { 2 => 'Video' }, Struct => \%sEntity },
    StreamReady => {
        Groups => { 2 => 'Video' },
        PrintConv => {
            true => 'True',
            false => 'False',
            unknown => 'Unknown',
        },
    },
    videoBitRate     => { Groups => { 2 => 'Video' }, Writable => 'integer', Name => 'VideoBitrate' },
    videoBitRateMode => {
        Name => 'VideoBitrateMode',
        Groups => { 2 => 'Video' },
        PrintConv => {
            fixed => 'Fixed',
            variable => 'Variable',
        },
    },
    videoEncodingProfile => { Groups => { 2 => 'Video' } },
    videoStreamsCount    => { Groups => { 2 => 'Video' }, Writable => 'integer' },
    # new IPTC video metadata 1.1 properties
    # (ref https://www.iptc.org/std/videometadatahub/recommendation/IPTC-VideoMetadataHub-props-Rec_1.1.html)
    SnapshotLink => { Groups => { 2 => 'Image' }, List => 'Bag', Struct => \%sLinkedImage, Name => 'Snapshot' },
);

#------------------------------------------------------------------------------
# PRISM
#
# NOTE: The "Avoid" flag is set for all PRISM tags

# my %obsolete = (
#     Notes => 'obsolete in 2.0',
#     ValueConvInv => sub {
#         my ($val, $self) = @_;
#         unless ($self->Options('IgnoreMinorErrors')) {
#             warn "Warning: [minor] Attempt to write obsolete tag\n";
#             return undef;
#         }
#         return $val;
#     }
# );

# PRISM structure definitions
my %prismPublicationDate = (
    STRUCT_NAME => 'prismPublicationDate',
    NAMESPACE   => 'prism',
    date        => { %dateTimeInfo, Groups => { 2 => 'Time'} },
    'a-platform'=> { },
);

# Publishing Requirements for Industry Standard Metadata (prism) (ref 2)
%Image::ExifTool::XMP::prism = (
    %xmpTableDefaults,
    GROUPS => { 0 => 'XMP', 1 => 'XMP-prism', 2 => 'Document' },
    NAMESPACE => 'prism',
    NOTES => q{
        Publishing Requirements for Industry Standard Metadata 3.0 namespace
        tags.  (see L<http://www.prismstandard.org/>)
    },
    acedemicField   => { }, # (3.0)
    aggregateIssueNumber => { Writable => 'integer' }, # (3.0)
    aggregationType => { List => 'Bag' },
    alternateTitle  => {
        List => 'Bag',
        Struct => { # (becomes a structure in 3.0)
            STRUCT_NAME => 'prismAlternateTitle',
            NAMESPACE   => 'prism',
            text        => { },
            'a-platform'=> { },
            'a-lang'    => { },
        },
    },
    blogTitle       => { }, # (3.0)
    blogURL         => { }, # (3.0)
    bookEdition     => { }, # (3.0)
    byteCount       => { Writable => 'integer' },
    channel         => {
        List => 'Bag',
        Struct => { # (becomes a structure in 3.0)
            STRUCT_NAME => 'prismChannel',
            NAMESPACE   => 'prism',
            channel     => { },
            subchannel1 => { },
            subchannel2 => { },
            subchannel3 => { },
            subchannel4 => { },
            'a-lang'    => { },
        },
    },
    complianceProfile=>{ PrintConv => { three => 'Three' } },
    contentType     => { }, # (3.0)
    copyrightYear   => { }, # (3.0)
    # copyright       => { Groups => { 2 => 'Author' } }, # (deprecated in 3.0)
    corporateEntity => { List => 'Bag' },
    coverDate       => { %dateTimeInfo, Groups => { 2 => 'Time'} },
    coverDisplayDate=> { },
    creationDate    => { %dateTimeInfo, Groups => { 2 => 'Time'} },
    dateRecieved    => { %dateTimeInfo, Groups => { 2 => 'Time'} },
    device          => { }, # (3.0)
    distributor     => { },
    doi             => { Name => 'DOI', Description => 'Digital Object Identifier' },
    edition         => { },
    eIssn           => { },
    #embargoDate     => { List => 'Bag', %dateTimeInfo, Groups => { 2 => 'Time'} }, # (deprecated in 3.0)
    endingPage      => { },
    event           => { List => 'Bag' },
    #expirationDate  => { List => 'Bag', %dateTimeInfo, Groups => { 2 => 'Time'} }, # (deprecated in 3.0)
    genre           => { List => 'Bag' },
    hasAlternative  => { List => 'Bag' },
    hasCorrection   => {
        Struct => { # (becomes a structure in 3.0)
            STRUCT_NAME => 'prismHasCorrection',
            NAMESPACE   => 'prism',
            text        => { },
            'a-platform'=> { },
            'a-lang'    => { },
        },
    },
    # hasPreviousVersion => { }, # (not in 3.0)
    hasTranslation  => { List => 'Bag' },
    industry        => { List => 'Bag' },
    isAlternativeOf => { List => 'Bag' }, # (3.0)
    isbn            => { Name => 'ISBN', List => 'Bag' }, # 2.1 (becomes a list in 3.0)
    isCorrectionOf  => { List => 'Bag' },
    issn            => { Name => 'ISSN' },
    issueIdentifier => { },
    issueName       => { },
    issueTeaser     => { }, # (3.0)
    issueType       => { }, # (3.0)
    isTranslationOf => { },
    keyword         => { List => 'Bag' },
    killDate        => {
        Struct => { # (becomes a structure in 3.0)
            STRUCT_NAME => 'prismKillDate',
            NAMESPACE   => 'prism',
            date        => { %dateTimeInfo, Groups => { 2 => 'Time'} },
            'a-platform'=> { }, #PH (missed in spec?)
        },
    },
   'link'           => { List => 'Bag' }, # (3.0)
    location        => { List => 'Bag' },
    # metadataContainer => { }, (not valid for PRISM XMP)
    modificationDate=> { %dateTimeInfo, Groups => { 2 => 'Time'} },
    nationalCatalogNumber => { }, # (3.0)
    number          => { },
    object          => { List => 'Bag' },
    onSaleDate => { # (3.0)
        List => 'Bag',
        Struct => {
            STRUCT_NAME => 'prismOnSaleDate',
            NAMESPACE   => 'prism',
            date        => { %dateTimeInfo, Groups => { 2 => 'Time'} },
            'a-platform'=> { },
        },
    },
    onSaleDay => { # (3.0)
        List => 'Bag',
        Struct => {
            STRUCT_NAME => 'prismOnSaleDay',
            NAMESPACE   => 'prism',
            day         => { }, #PH (not named in spec)
            'a-platform'=> { },
        },
    },
    offSaleDate => { # (3.0)
        List => 'Bag',
        Struct => {
            STRUCT_NAME => 'prismOffSaleDate',
            NAMESPACE   => 'prism',
            date        => { %dateTimeInfo, Groups => { 2 => 'Time'} },
            'a-platform'=> { },
        },
    },
    organization    => { List => 'Bag' },
    originPlatform  => {
        List => 'Bag',
        PrintConv => {
            email       => 'E-Mail',
            mobile      => 'Mobile',
            broadcast   => 'Broadcast',
            web         => 'Web',
           'print'      => 'Print',
            recordableMedia => 'Recordable Media',
            other       => 'Other',
        },
    },
    pageCount       => { Writable => 'integer' }, # (3.0)
    pageProgressionDirection => { # (3.0)
        PrintConv => { LTR => 'Left to Right', RTL => 'Right to Left' },
    },
    pageRange       => { List => 'Bag' },
    person          => { },
    platform        => { }, # (3.0)
    productCode     => { }, # (3.0)
    profession      => { }, # (3.0)
    publicationDate => {
        List => 'Bag',
        Struct => \%prismPublicationDate, # (becomes a structure in 3.0)
    },
    publicationDisplayDate => { # (3.0)
        List => 'Bag',
        Struct => \%prismPublicationDate,
    },
    publicationName => { },
    publishingFrequency => { }, # (3.0)
    rating          => { },
    # rightsAgent     => { }, # (deprecated in 3.0)
    samplePageRange => { }, # (3.0)
    section         => { },
    sellingAgency   => { }, # (3.0)
    seriesNumber    => { Writable => 'integer' }, # (3.0)
    seriesTitle     => { }, # (3.0)
    sport           => { }, # (3.0)
    startingPage    => { },
    subsection1     => { },
    subsection2     => { },
    subsection3     => { },
    subsection4     => { },
    subtitle        => { }, # (3.0)
    supplementDisplayID => { }, # (3.0)
    supplementStartingPage => { }, # (3.0)
    supplementTitle => { }, # (3.0)
    teaser          => { List => 'Bag' },
    ticker          => { List => 'Bag' },
    timePeriod      => { },
    url             => {
        Name => 'URL',
        List => 'Bag',
        Struct => { # (becomes a structure in 3.0)
            STRUCT_NAME => 'prismUrl',
            NAMESPACE   => 'prism',
            url         => { },
            'a-platform'=> { },
        },
    },
    uspsNumber      => { }, # (3.0)
    versionIdentifier => { },
    volume          => { },
    wordCount       => { Writable => 'integer' },
# tags that existed in version 1.3
#    category        => { %obsolete, List => 'Bag' },
#    hasFormat       => { %obsolete, List => 'Bag' },
#    hasPart         => { %obsolete, List => 'Bag' },
#    isFormatOf      => { %obsolete, List => 'Bag' },
#    isPartOf        => { %obsolete },
#    isReferencedBy  => { %obsolete, List => 'Bag' },
#    isRequiredBy    => { %obsolete, List => 'Bag' },
#    isVersionOf     => { %obsolete },
#    objectTitle     => { %obsolete, List => 'Bag' },
#    receptionDate   => { %obsolete },
#    references      => { %obsolete, List => 'Bag' },
#    requires        => { %obsolete, List => 'Bag' },
# tags in older versions
#    page
#    contentLength
#    creationTime
#    expirationTime
#    hasVersion
#    isAlternativeFor
#    isBasedOn
#    isBasisFor
#    modificationTime
#    publicationTime
#    receptionTime
#    releaseTime
);

# PRISM Rights Language namespace (prl) (ref 2)
%Image::ExifTool::XMP::prl = (
    %xmpTableDefaults,
    GROUPS => { 0 => 'XMP', 1 => 'XMP-prl', 2 => 'Document' },
    NAMESPACE => 'prl',
    NOTES => q{
        PRISM Rights Language 2.1 namespace tags.  These tags have been deprecated
        since the release of the PRISM Usage Rights 3.0. (see
        L<http://www.prismstandard.org/>)
    },
    geography       => { List => 'Bag' },
    industry        => { List => 'Bag' },
    usage           => { List => 'Bag' },
);

# PRISM Usage Rights namespace (prismusagerights) (ref 2)
%Image::ExifTool::XMP::pur = (
    %xmpTableDefaults,
    GROUPS => { 0 => 'XMP', 1 => 'XMP-pur', 2 => 'Document' },
    NAMESPACE => 'pur',
    NOTES => q{
        PRISM Usage Rights 3.0 namespace tags.  (see
        L<http://www.prismstandard.org/>)
    },
    adultContentWarning => { List => 'Bag' },
    agreement           => { List => 'Bag' },
    copyright           => {
        # (not clear in 3.0 spec, which lists only "bag Text", and called
        #  "copyrightDate" instead of "copyright" the PRISM basic 3.0 spec)
        Writable => 'lang-alt',
        Groups => { 2 => 'Author' },
    },
    creditLine          => { List => 'Bag' },
    embargoDate         => { List => 'Bag', %dateTimeInfo, Groups => { 2 => 'Time'} },
    exclusivityEndDate  => { List => 'Bag', %dateTimeInfo, Groups => { 2 => 'Time'} },
    expirationDate      => { List => 'Bag', %dateTimeInfo, Groups => { 2 => 'Time'} },
    imageSizeRestriction=> { },
    optionEndDate       => { List => 'Bag', %dateTimeInfo, Groups => { 2 => 'Time'} },
    permissions         => { List => 'Bag' },
    restrictions        => { List => 'Bag' },
    reuseProhibited     => { Writable => 'boolean' },
    rightsAgent         => { },
    rightsOwner         => { },
    # usageFee            => { List => 'Bag' }, # (not in 3.0)
);

# PRISM Metadata for Images namespace (pmi) (ref 2)
%Image::ExifTool::XMP::pmi = (
    %xmpTableDefaults,
    GROUPS => { 0 => 'XMP', 1 => 'XMP-pmi', 2 => 'Image' },
    NAMESPACE => 'pmi',
    NOTES => q{
        PRISM Metadata for Images 3.0 namespace tags.  (see
        L<http://www.prismstandard.org/>)
    },
    color => {
        PrintConv => {
            bw => 'BW',
            color => 'Color',
            sepia => 'Sepia',
            duotone => 'Duotone',
            tritone => 'Tritone',
            quadtone => 'Quadtone',
        },
    },
    contactInfo     => { },
    displayName     => { },
    distributorProductID => { },
    eventAlias      => { },
    eventEnd        => { },
    eventStart      => { },
    eventSubtype    => { },
    eventType       => { },
    field           => { },
    framing         => { },
    location        => { },
    make            => { },
    manufacturer    => { },
    model           => { },
    modelYear       => { },
    objectDescription=>{ },
    objectSubtype   => { },
    objectType      => { },
    orientation => {
        PrintConv => {
            horizontal => 'Horizontal',
            vertical => 'Vertical',
        }
    },
    positionDescriptor => { },
    productID       => { },
    productIDType   => { },
    season => {
        PrintConv => {
            spring => 'Spring',
            summer => 'Summer',
            fall => 'Fall',
            winter => 'Winter',
        },
    },
    sequenceName    => { },
    sequenceNumber  => { },
    sequenceTotalNumber => { },
    setting         => { },
    shootID         => { },
    slideshowName   => { },
    slideshowNumber => { Writable => 'integer' },
    slideshowTotalNumber => { Writable => 'integer' },
    viewpoint       => { },
    visualTechnique => { },
);

# PRISM Recipe Metadata (prm) (ref 2)
%Image::ExifTool::XMP::prm = (
    %xmpTableDefaults,
    GROUPS => { 0 => 'XMP', 1 => 'XMP-prm', 2 => 'Document' },
    NAMESPACE => 'prm',
    NOTES => q{
        PRISM Recipe Metadata 3.0 namespace tags.  (see
        L<http://www.prismstandard.org/>)
    },
    cookingEquipment    => { },
    cookingMethod       => { },
    course              => { },
    cuisine             => { },
    dietaryNeeds        => { },
    dishType            => { },
    duration            => { },
    ingredientExclusion => { },
    mainIngredient      => { },
    meal                => { },
    recipeEndingPage    => { },
    recipePageRange     => { },
    recipeSource        => { },
    recipeStartingPage  => { },
    recipeTitle         => { },
    servingSize         => { },
    skillLevel          => { },
    specialOccasion     => { },
    yield               => { },
);

#------------------------------------------------------------------------------

# DICOM namespace properties (DICOM) (ref PH, written by CS3)
%Image::ExifTool::XMP::DICOM = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-DICOM', 2 => 'Image' },
    NAMESPACE => 'DICOM',
    NOTES => q{
        DICOM namespace tags.  These XMP tags allow some DICOM information to be
        stored in files of other than DICOM format.  See the
        L<DICOM Tags documentation|Image::ExifTool::TagNames/DICOM Tags> for a list
        of tags available in DICOM-format files.
    },
    # change some tag names to correspond with DICOM tags
    PatientName             => { },
    PatientID               => { },
    PatientSex              => { },
    PatientDOB => {
        Name => 'PatientBirthDate',
        Groups => { 2 => 'Time' },
        %dateTimeInfo,
    },
    StudyID                 => { },
    StudyPhysician          => { },
    StudyDateTime           => { Groups => { 2 => 'Time' }, %dateTimeInfo },
    StudyDescription        => { },
    SeriesNumber            => { },
    SeriesModality          => { },
    SeriesDateTime          => { Groups => { 2 => 'Time' }, %dateTimeInfo },
    SeriesDescription       => { },
    EquipmentInstitution    => { },
    EquipmentManufacturer   => { },
);

# PixelLive namespace properties (PixelLive) (ref 3)
%Image::ExifTool::XMP::PixelLive = (
    GROUPS => { 1 => 'XMP-PixelLive', 2 => 'Image' },
    NAMESPACE => 'PixelLive',
    NOTES => q{
        PixelLive namespace tags.  These tags are not writable becase they are very
        uncommon and I haven't been able to locate a reference which gives the
        namespace URI.
    },
    AUTHOR    => { Name => 'Author',   Avoid => 1, Groups => { 2 => 'Author' } },
    COMMENTS  => { Name => 'Comments', Avoid => 1 },
    COPYRIGHT => { Name => 'Copyright',Avoid => 1, Groups => { 2 => 'Author' } },
    DATE      => { Name => 'Date',     Avoid => 1, Groups => { 2 => 'Time' } },
    GENRE     => { Name => 'Genre',    Avoid => 1 },
    TITLE     => { Name => 'Title',    Avoid => 1 },
);

# Extensis Portfolio tags (extensis) (ref 11)
%Image::ExifTool::XMP::extensis = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-extensis', 2 => 'Image' },
    NAMESPACE => 'extensis',
    NOTES => 'Tags used by Extensis Portfolio.',
    Approved     => { Writable => 'boolean' },
    ApprovedBy   => { },
    ClientName   => { },
    JobName      => { },
    JobStatus    => { },
    RoutedTo     => { },
    RoutingNotes => { },
    WorkToDo     => { },
);

# IDimager structures (ref PH)
my %sTagStruct;
%sTagStruct = (
    STRUCT_NAME => 'TagStructure',
    NAMESPACE => 'ics',
    LabelName => { },
    Reference => { },
    ParentReference => { },
    SubLabels => { Struct => \%sTagStruct, List => 'Bag' },
);
my %sSubVersion = (
    STRUCT_NAME => 'SubVersion',
    NAMESPACE => 'ics',
    VersRef => { },
    FileName => { },
);

# IDimager namespace (ics) (ref PH)
%Image::ExifTool::XMP::ics = (
    %xmpTableDefaults,
    GROUPS => { 0 => 'XMP', 1 => 'XMP-ics', 2 => 'Image' },
    NAMESPACE => 'ics',
    NOTES => q{
        Tags used by IDimager.  Nested TagStructure structures are unrolled to an
        arbitrary depth of 6 to avoid infinite recursion.
    },
    ImageRef => { },
    TagStructure => { Struct => \%sTagStruct, List => 'Bag' },
    TagStructureLabelName => { Name => 'LabelName1', Flat => 1 },
    TagStructureReference => { Name => 'Reference1', Flat => 1 },
    TagStructureSubLabels => { Name => 'SubLables1', Flat => 1 },
    TagStructureParentReference => { Name => 'ParentReference1', Flat => 1 },
    TagStructureSubLabelsLabelName => { Name => 'LabelName2', Flat => 1 },
    TagStructureSubLabelsReference => { Name => 'Reference2', Flat => 1 },
    TagStructureSubLabelsSubLabels => { Name => 'SubLables2', Flat => 1 },
    TagStructureSubLabelsParentReference => { Name => 'ParentReference2', Flat => 1 },
    TagStructureSubLabelsSubLabelsLabelName => { Name => 'LabelName3', Flat => 1 },
    TagStructureSubLabelsSubLabelsReference => { Name => 'Reference3', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabels => { Name => 'SubLables3', Flat => 1 },
    TagStructureSubLabelsSubLabelsParentReference => { Name => 'ParentReference3', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsLabelName => { Name => 'LabelName4', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsReference => { Name => 'Reference4', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsSubLabels => { Name => 'SubLabels4', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsParentReference => { Name => 'ParentReference4', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsSubLabelsLabelName => { Name => 'LabelName5', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsSubLabelsReference => { Name => 'Reference5', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsSubLabelsSubLabels => { Name => 'SubLabels5', Flat => 1, NoSubStruct => 1 }, # break infinite recursion
    TagStructureSubLabelsSubLabelsSubLabelsSubLabelsParentReference => { Name => 'ParentReference5', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsSubLabelsSubLabelsLabelName => { Name => 'LabelName6', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsSubLabelsSubLabelsReference => { Name => 'Reference6', Flat => 1 },
    TagStructureSubLabelsSubLabelsSubLabelsSubLabelsSubLabelsParentReference => { Name => 'ParentReference6', Flat => 1 },
    SubVersions => { Struct => \%sSubVersion, List => 'Bag' },
    SubVersionsVersRef => { Name => 'SubVersionReference', Flat => 1 },
    SubVersionsFileName => { Name => 'SubVersionFileName', Flat => 1 },
    TimeStamp  => { Avoid => 1, Groups => { 2 => 'Time' }, %dateTimeInfo },
    AppVersion => { Avoid => 1 },
);

# ACDSee namespace (acdsee) (ref PH)
%Image::ExifTool::XMP::acdsee = (
    %xmpTableDefaults,
    GROUPS => { 0 => 'XMP', 1 => 'XMP-acdsee', 2 => 'Image' },
    NAMESPACE => 'acdsee',
    NOTES => q{
        ACD Systems ACDSee namespace tags.

        (A note to software developers: Re-inventing your own private tags instead
        of using the equivalent tags in standard XMP namespaces defeats one of the
        most valuable features of metadata: interoperability.  Your applications
        mumble to themselves instead of speaking out for the rest of the world to
        hear.)
    },
    author     => { Avoid => 1, Groups => { 2 => 'Author' } },
    caption    => { Avoid => 1 },
    categories => { Avoid => 1 },
    collections=> { Avoid => 1 },
    datetime   => { Name => 'DateTime', Avoid => 1, Groups => { 2 => 'Time' }, %dateTimeInfo },
    keywords   => { Avoid => 1, List => 'Bag' },
    notes      => { Avoid => 1 },
    rating     => { Avoid => 1, Writable => 'real' }, # integer?
    tagged     => { Avoid => 1, Writable => 'boolean' },
    rawrppused => { Writable => 'boolean' },
    rpp => {
        Name => 'RPP',
        Writable => 'lang-alt',
        Notes => 'raw processing settings in XML format',
        Binary => 1,
    },
    dpp => {
        Name => 'DPP',
        Writable => 'lang-alt',
        Notes => 'newer version of XML raw processing settings',
        Binary => 1,
    },
    # more tags (ref forum6840)
    FixtureIdentifier   => { Avoid => 1 },
    EditStatus          => { Avoid => 1 },
    ReleaseDate         => { Avoid => 1 },
    ReleaseTime         => { Avoid => 1 },
    OriginatingProgram  => { Avoid => 1 },
    ObjectCycle         => { Avoid => 1 },
    Snapshots           => { Avoid => 1, List => 'Bag', Binary => 1 },
);

# Picture Licensing Universal System namespace properties (xmpPLUS)
%Image::ExifTool::XMP::xmpPLUS = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-xmpPLUS', 2 => 'Author' },
    NAMESPACE => 'xmpPLUS',
    NOTES => q{
        XMP Picture Licensing Universal System (PLUS) tags as written by some older
        Adobe applications.  See L<PLUS XMP Tags|Image::ExifTool::TagNames/PLUS XMP Tags>
        for the current PLUS tags.
    },
    CreditLineReq   => { Writable => 'boolean', Avoid => 1 },
    ReuseAllowed    => { Writable => 'boolean', Avoid => 1 },
);

# Creative Commons namespace properties (cc) (ref 5)
%Image::ExifTool::XMP::cc = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-cc', 2 => 'Author' },
    NAMESPACE => 'cc',
    NOTES => q{
        Creative Commons namespace tags.  Note that the CC specification for XMP is
        non-existent, so ExifTool must make some assumptions about the format of the
        specific properties in XMP (see L<http://creativecommons.org/ns>).
    },
    # Work properties
    license         => { Resource => 1 },
    attributionName => { },
    attributionURL  => { Resource => 1 },
    morePermissions => { Resource => 1 },
    useGuidelines   => { Resource => 1 },
    # License properties
    permits => {
        List => 'Bag',
        Resource => 1,
        PrintConv => {
            'cc:Sharing' => 'Sharing',
            'cc:DerivativeWorks' => 'Derivative Works',
            'cc:Reproduction' => 'Reproduction',
            'cc:Distribution' => 'Distribution',
        },
    },
    requires => {
        List => 'Bag',
        Resource => 1,
        PrintConv => {
            'cc:Copyleft' => 'Copyleft',
            'cc:LesserCopyleft' => 'Lesser Copyleft',
            'cc:SourceCode' => 'Source Code',
            'cc:ShareAlike' => 'Share Alike',
            'cc:Notice' => 'Notice',
            'cc:Attribution' => 'Attribution',
        },
    },
    prohibits => {
        List => 'Bag',
        Resource => 1,
        PrintConv => {
            'cc:HighIncomeNationUse' => 'High Income Nation Use',
            'cc:CommercialUse' => 'Commercial Use',
        },
    },
    jurisdiction    => { Resource => 1 },
    legalcode       => { Name => 'LegalCode', Resource => 1 },
    deprecatedOn    => { %dateTimeInfo, Groups => { 2 => 'Time' } },
);

# Description Explorer namespace properties (dex) (ref 6)
%Image::ExifTool::XMP::dex = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-dex', 2 => 'Image' },
    NAMESPACE => 'dex',
    NOTES => q{
        Description Explorer namespace tags.  These tags are not very common.  The
        Source and Rating tags are avoided when writing due to name conflicts with
        other XMP tags.  (see L<http://www.optimasc.com/products/fileid/>)
    },
    crc32       => { Name => 'CRC32', Writable => 'integer' },
    source      => { Avoid => 1 },
    shortdescription => {
        Name => 'ShortDescription',
        Writable => 'lang-alt',
    },
    licensetype => {
        Name => 'LicenseType',
        PrintConv => {
            unknown        => 'Unknown',
            shareware      => 'Shareware',
            freeware       => 'Freeware',
            adware         => 'Adware',
            demo           => 'Demo',
            commercial     => 'Commercial',
           'public domain' => 'Public Domain',
           'open source'   => 'Open Source',
        },
    },
    revision    => { },
    rating      => { Avoid => 1 },
    os          => { Name => 'OS', Writable => 'integer' },
    ffid        => { Name => 'FFID' },
);

# iView MediaPro namespace properties (mediapro) (ref PH)
%Image::ExifTool::XMP::MediaPro = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-mediapro', 2 => 'Image' },
    NAMESPACE => 'mediapro',
    NOTES => 'iView MediaPro namespace tags.',
    Event       => {
        Avoid => 1,
        Notes => 'avoided due to conflict with XMP-iptcExt:Event',
    },
    Location    => {
        Avoid => 1,
        Groups => { 2 => 'Location' },
        Notes => 'avoided due to conflict with XMP-iptcCore:Location',
    },
    Status      => { },
    People      => { List => 'Bag' },
    UserFields  => { List => 'Bag' },
    CatalogSets => { List => 'Bag' },
);

# Microsoft ExpressionMedia namespace properties (expressionmedia)
# (ref http://u88.n24.queensu.ca/exiftool/forum/index.php/topic,4235.0.html)
%Image::ExifTool::XMP::ExpressionMedia = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-expressionmedia', 2 => 'Image' },
    NAMESPACE => 'expressionmedia',
    NOTES => q{
        Microsoft Expression Media namespace tags.  These tags are avoided when
        writing due to name conflicts with tags in other schemas.
    },
    Event       => { Avoid => 1 },
    Status      => { Avoid => 1 },
    People      => { Avoid => 1, List => 'Bag' },
    CatalogSets => { Avoid => 1, List => 'Bag' },
);

# DigiKam namespace tags (ref PH)
%Image::ExifTool::XMP::digiKam = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-digiKam', 2 => 'Image' },
    NAMESPACE => 'digiKam',
    NOTES => 'DigiKam namespace tags.',
    CaptionsAuthorNames    => { Writable => 'lang-alt' },
    CaptionsDateTimeStamps => { Writable => 'lang-alt', Groups => { 2 => 'Time' } },
    TagsList               => { List => 'Seq' },
    ColorLabel             => { },
    PickLabel              => { },
    ImageHistory           => { Avoid => 1, Notes => 'different format from EXIF:ImageHistory' },
    LensCorrectionSettings => { },
    ImageUniqueID          => { Avoid => 1 },
);

# SWF namespace tags (ref PH)
%Image::ExifTool::XMP::swf = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-swf', 2 => 'Image' },
    NAMESPACE => 'swf',
    NOTES => 'Adobe SWF namespace tags.',
    type         => { Avoid => 1 },
    bgalpha      => { Name => 'BackgroundAlpha', Writable => 'integer' },
    forwardlock  => { Name => 'ForwardLock',     Writable => 'boolean' },
    maxstorage   => { Name => 'MaxStorage',      Writable => 'integer' }, # (CS5)
);

# Sony Ericsson cell phone location tags
# refs: http://www.opencellid.org/api
# http://zonetag.research.yahoo.com/faq_location.php
# http://www.cs.columbia.edu/sip/drafts/LIF%20TS%20101%20v2.0.0.pdf
%Image::ExifTool::XMP::cell = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-cell', 2 => 'Location' },
    NAMESPACE => 'cell',
    NOTES => 'Location tags written by some Sony Ericsson phones.',
    mcc     => { Name => 'MobileCountryCode' },
    mnc     => { Name => 'MobileNetworkCode' },
    lac     => { Name => 'LocationAreaCode' },
    cellid  => { Name => 'CellTowerID' },
    cgi     => { Name => 'CellGlobalID' },
    r       => { Name => 'CellR' }, # (what is this? Radius?)
);

# Apple adjustment settings (ref PH)
%Image::ExifTool::XMP::aas = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-aas', 2 => 'Image' },
    NAMESPACE => 'aas',
    NOTES => 'Apple Adjustment Settings used by iPhone/iPad.',
    CropX      => { Writable => 'integer', Avoid => 1 },
    CropY      => { Writable => 'integer', Avoid => 1 },
    CropW      => { Writable => 'integer', Avoid => 1 },
    CropH      => { Writable => 'integer', Avoid => 1 },
    AffineA    => { Writable => 'real' },
    AffineB    => { Writable => 'real' },
    AffineC    => { Writable => 'real' },
    AffineD    => { Writable => 'real' },
    AffineX    => { Writable => 'real' },
    AffineY    => { Writable => 'real' },
    Vibrance   => { Writable => 'real', Avoid => 1 },
    Curve0x    => { Writable => 'real' },
    Curve0y    => { Writable => 'real' },
    Curve1x    => { Writable => 'real' },
    Curve1y    => { Writable => 'real' },
    Curve2x    => { Writable => 'real' },
    Curve2y    => { Writable => 'real' },
    Curve3x    => { Writable => 'real' },
    Curve3y    => { Writable => 'real' },
    Curve4x    => { Writable => 'real' },
    Curve4y    => { Writable => 'real' },
    Shadows    => { Writable => 'real', Avoid => 1 },
    Highlights => { Writable => 'real', Avoid => 1 },
    # the following from StarGeek
    FaceBalanceOrigI    => { Writable => 'real' },
    FaceBalanceOrigQ    => { Writable => 'real' },
    FaceBalanceStrength => { Writable => 'real' },
    FaceBalanceWarmth   => { Writable => 'real' },
);

# Adobe creatorAtom properties (ref PH)
%Image::ExifTool::XMP::creatorAtom = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-creatorAtom', 2 => 'Image' },
    NAMESPACE => 'creatorAtom',
    NOTES => 'Adobe creatorAtom tags, written by After Effects.',
    macAtom => {
        Struct => {
            STRUCT_NAME => 'MacAtom',
            NAMESPACE   => 'creatorAtom',
            applicationCode      => { },
            invocationAppleEvent => { },
            posixProjectPath     => { },
        },
    },
    windowsAtom => {
        Struct => {
            STRUCT_NAME => 'WindowsAtom',
            NAMESPACE   => 'creatorAtom',
            extension       => { },
            invocationFlags => { },
            uncProjectPath  => { },
        },
    },
    aeProjectLink => { # (After Effects Project Link)
        Struct => {
            STRUCT_NAME => 'AEProjectLink',
            NAMESPACE   => 'creatorAtom',
            renderTimeStamp         => { Writable => 'integer' },
            compositionID           => { },
            renderQueueItemID       => { },
            renderOutputModuleIndex => { },
            fullPath                => { },
        },
    },
);

# FastPictureViewer namespace properties (http://www.fastpictureviewer.com/help/#rtfcomments)
%Image::ExifTool::XMP::fpv = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-fpv', 2 => 'Image' },
    NAMESPACE => 'fpv',
    NOTES => q{
        Fast Picture Viewer tags (see
        L<http://www.fastpictureviewer.com/help/#rtfcomments>).
    },
    RichTextComment => { },
);

# Apple FaceInfo namespace properties (ref PH)
%Image::ExifTool::XMP::apple_fi = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-apple-fi', 2 => 'Image' },
    NAMESPACE => 'apple-fi',
    NOTES => q{
        Face information tags written by the Apple iPhone 5 inside the mwg-rs
        RegionExtensions.
    },
    Timestamp => {
        Name => 'TimeStamp',
        Writable => 'integer',
        # (don't know how to convert this)
    },
    FaceID          => { Writable => 'integer' },
    AngleInfoRoll   => { Writable => 'integer' },
    AngleInfoYaw    => { Writable => 'integer' },
    ConfidenceLevel => { Writable => 'integer' },
);

# Google audio namespace
%Image::ExifTool::XMP::GAudio = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-GAudio', 2 => 'Audio' },
    NAMESPACE => 'GAudio',
    Data => {
        Name => 'AudioData',
        ValueConv => 'Image::ExifTool::XMP::DecodeBase64($val)',
        ValueConvInv => 'Image::ExifTool::XMP::EncodeBase64($val)',
    },
    Mime => { Name => 'AudioMimeType' },
);

# Google image namespace
%Image::ExifTool::XMP::GImage = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-GImage', 2 => 'Image' },
    NAMESPACE => 'GImage',
    Data => {
        Name => 'ImageData',
        ValueConv => 'Image::ExifTool::XMP::DecodeBase64($val)',
        ValueConvInv => 'Image::ExifTool::XMP::EncodeBase64($val)',
    },
    Mime => { Name => 'ImageMimeType' },
);

# Google panorama namespace properties
# (ref http://u88.n24.queensu.ca/exiftool/forum/index.php/topic,4569.0.html)
%Image::ExifTool::XMP::GPano = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-GPano', 2 => 'Image' },
    NAMESPACE => 'GPano',
    NOTES => q{
        Panorama tags written by Google Photosphere. See
        L<https://developers.google.com/panorama/metadata/> for the specification.
    },
    UsePanoramaViewer               => { Writable => 'boolean' },
    CaptureSoftware                 => { },
    StitchingSoftware               => { },
    ProjectionType                  => { },
    PoseHeadingDegrees              => { Writable => 'real' },
    PosePitchDegrees                => { Writable => 'real' },
    PoseRollDegrees                 => { Writable => 'real' },
    InitialViewHeadingDegrees       => { Writable => 'real' },
    InitialViewPitchDegrees         => { Writable => 'real' },
    InitialViewRollDegrees          => { Writable => 'real' },
    InitialHorizontalFOVDegrees     => { Writable => 'real' },
    FirstPhotoDate                  => { %dateTimeInfo, Groups => { 2 => 'Time' } },
    LastPhotoDate                   => { %dateTimeInfo, Groups => { 2 => 'Time' } },
    SourcePhotosCount               => { Writable => 'integer' },
    ExposureLockUsed                => { Writable => 'boolean' },
    CroppedAreaImageWidthPixels     => { Writable => 'real' },
    CroppedAreaImageHeightPixels    => { Writable => 'real' },
    FullPanoWidthPixels             => { Writable => 'real' },
    FullPanoHeightPixels            => { Writable => 'real' },
    CroppedAreaLeftPixels           => { Writable => 'real' },
    CroppedAreaTopPixels            => { Writable => 'real' },
    InitialCameraDolly              => { Writable => 'real' },
    # (the following have been observed, but are not in the specification)
    LargestValidInteriorRectLeft    => { Writable => 'real' },
    LargestValidInteriorRectTop     => { Writable => 'real' },
    LargestValidInteriorRectWidth   => { Writable => 'real' },
    LargestValidInteriorRectHeight  => { Writable => 'real' },
);

# Google Spherical Images namespace (ref https://github.com/google/spatial-media/blob/master/docs/spherical-video-rfc.md)
%Image::ExifTool::XMP::GSpherical = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-GSpherical', 2 => 'Image' },
    NAMESPACE => 'GSpherical',
    NOTES => q{
        Not actually XMP.  These RDF/XML tags are used in Google spherical MP4
        videos.  See
        L<https://github.com/google/spatial-media/blob/master/docs/spherical-video-rfc.md>
        for the specification.
    },
    # (avoid due to conflicts with XMP-GPano tags)
    Spherical                   => { Avoid => 1, Writable => 'boolean' },
    Stitched                    => { Avoid => 1, Writable => 'boolean' },
    StitchingSoftware           => { Avoid => 1 },
    ProjectionType              => { Avoid => 1 },
    StereoMode                  => { Avoid => 1 },
    SourceCount                 => { Avoid => 1, Writable => 'integer' },
    InitialViewHeadingDegrees   => { Avoid => 1, Writable => 'real' },
    InitialViewPitchDegrees     => { Avoid => 1, Writable => 'real' },
    InitialViewRollDegrees      => { Avoid => 1, Writable => 'real' },
    Timestamp                   => {
        Name => 'TimeStamp',
        Groups => { 2 => 'Time' },
        Avoid => 1,
        Writable => 'date',
        Shift => 'Time',
        ValueConv => 'ConvertUnixTime($val)', #(NC)
        ValueConvInv => 'GetUnixTime($val)',
        PrintConv => '$self->ConvertDateTime($val)',
        PrintConvInv => '$self->InverseDateTime($val)',
    },
    FullPanoWidthPixels         => { Avoid => 1, Writable => 'integer' },
    FullPanoHeightPixels        => { Avoid => 1, Writable => 'integer' },
    CroppedAreaImageWidthPixels => { Avoid => 1, Writable => 'integer' },
    CroppedAreaImageHeightPixels=> { Avoid => 1, Writable => 'integer' },
    CroppedAreaLeftPixels       => { Avoid => 1, Writable => 'integer' },
    CroppedAreaTopPixels        => { Avoid => 1, Writable => 'integer' },
);

# Getty Images namespace (ref PH)
%Image::ExifTool::XMP::GettyImages = (
    %xmpTableDefaults,
    GROUPS => { 1 => 'XMP-getty', 2 => 'Image' },
    NAMESPACE => 'GettyImagesGIFT',
    NOTES => q{
        The actual Getty Images namespace prefix is "GettyImagesGIFT", which is the
        prefix recorded in the file, but ExifTool shortens this for the family 1
        group name.
    },
    Personality         => { },
    OriginalFilename    => { Name => 'OriginalFileName' },
    ParentMEID          => { },
    # the following from StarGeek
    AssetID             => { },
    CallForImage        => { },
    CameraFilename      => { },
    CameraMakeModel     => { Avoid => 1 },
    Composition         => { },
    CameraSerialNumber  => { Avoid => 1 },
    ExclusiveCoverage   => { },
    GIFTFtpPriority     => { },
    ImageRank           => { },
    MediaEventIdDate    => { },
    OriginalCreateDateTime => { %dateTimeInfo, Groups => { 2 => 'Time' }, Avoid => 1 },
    ParentMediaEventID  => { },
    PrimaryFTP          => { List => 'Bag' },
    RoutingDestinations => { List => 'Bag' },
    RoutingExclusions   => { List => 'Bag' },
    SecondaryFTP        => { List => 'Bag' },
    TimeShot            => { },
);

# SVG namespace properties (ref 9)
%Image::ExifTool::XMP::SVG = (
    GROUPS => { 0 => 'SVG', 1 => 'SVG', 2 => 'Image' },
    NAMESPACE => 'svg',
    LANG_INFO => \&GetLangInfo,
    NOTES => q{
        SVG (Scalable Vector Graphics) image tags.  By default, only the top-level
        SVG and Metadata tags are extracted from these images, but all graphics tags
        may be extracted by setting the Unknown option to 2 (-U on the command
        line).  The SVG tags are not part of XMP as such, but are included with the
        XMP module for convenience.  (see L<http://www.w3.org/TR/SVG11/>)
    },
    version    => 'SVGVersion',
    id         => 'ID',
    metadataId => 'MetadataID',
    width      => {
        Name => 'ImageWidth',
        ValueConv => '$val =~ s/px$//; $val',
    },
    height     => {
        Name => 'ImageHeight',
        ValueConv => '$val =~ s/px$//; $val',
    },
);

# table to add tags in other namespaces
%Image::ExifTool::XMP::otherSVG = (
    GROUPS => { 0 => 'SVG', 2 => 'Unknown' },
    LANG_INFO => \&GetLangInfo,
    NAMESPACE => undef, # variable namespace
);

# set "Avoid" flag for all PRISM tags
my ($table, $key);
foreach $table (
    \%Image::ExifTool::XMP::prism,
    \%Image::ExifTool::XMP::prl,
    \%Image::ExifTool::XMP::pur,
    \%Image::ExifTool::XMP::pmi,
    \%Image::ExifTool::XMP::prm)
{
    foreach $key (TagTableKeys($table)) {
        $$table{$key}{Avoid} = 1;
    }
}


1;  #end

__END__

=head1 NAME

Image::ExifTool::XMP2.pl - Additional XMP namespace definitions

=head1 SYNOPSIS

This module is loaded automatically by Image::ExifTool when required.

=head1 DESCRIPTION

This file contains definitions for less common XMP namespaces.

=head1 AUTHOR

Copyright 2003-2017, Phil Harvey (phil at owl.phy.queensu.ca)

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 REFERENCES

=over 4

=item L<http://ns.useplus.org/>

=item L<http://www.prismstandard.org/>

=item L<http://www.portfoliofaq.com/pfaq/v7mappings.htm>

=item L<http://www.iptc.org/IPTC4XMP/>

=item L<http://creativecommons.org/technology/xmp>

=item L<http://www.optimasc.com/products/fileid/xmp-extensions.pdf>

=item L<http://www.w3.org/TR/SVG11/>

=back

=head1 SEE ALSO

L<Image::ExifTool::TagNames/XMP Tags>,
L<Image::ExifTool(3pm)|Image::ExifTool>

=cut
