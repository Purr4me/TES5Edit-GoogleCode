object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'TES5View'
  ClientHeight = 647
  ClientWidth = 948
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Padding.Left = 3
  Padding.Top = 3
  Padding.Right = 3
  Padding.Bottom = 3
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splElements: TSplitter
    Left = 458
    Top = 33
    Height = 587
    AutoSnap = False
    MinSize = 250
    ResizeStyle = rsUpdate
    ExplicitLeft = 457
    ExplicitTop = 32
    ExplicitHeight = 594
  end
  object stbMain: TStatusBar
    AlignWithMargins = True
    Left = 3
    Top = 623
    Width = 942
    Height = 21
    Margins.Left = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Panels = <
      item
        Width = 50
      end
      item
        Alignment = taRightJustify
        Style = psOwnerDraw
        Width = 104
      end>
    OnMouseDown = stbMainMouseDown
    OnDrawPanel = stbMainDrawPanel
    OnResize = stbMainResize
  end
  object Panel1: TPanel
    Left = 461
    Top = 33
    Width = 484
    Height = 587
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
    object pgMain: TPageControl
      Left = 0
      Top = 0
      Width = 480
      Height = 583
      ActivePage = tbsView
      Align = alClient
      RaggedRight = True
      TabOrder = 0
      TabPosition = tpBottom
      object tbsView: TTabSheet
        Caption = '查看'
        OnShow = tbsViewShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object imgFlattr: TImage
          Left = 312
          Top = 520
          Width = 80
          Height = 80
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000640000
            001108060000002B0D09260000000467414D410000B18E7CFB519300000A3969
            43435050686F746F73686F70204943432070726F66696C65000048C79D967754
            54D71687CFBD777AA1CD30025286DEBBC000D27B935E456198196028030E3334
            B121A2021145449A224850C480D150245644B1101454B007240828311845542C
            6F46D68BAEACBCF7F2F2FBE3AC6FEDB3F7B9FBECBDCF5A170092A72F9797064B
            0190CA13F0833C9CE911915174EC0080011E608029004C5646BA5FB07B0810C9
            CBCD859E2172025F0401F07A58BC0270D3D033804E07FF9FA459E97C81E89800
            119BB339192C11178838254B902EB6CF8A981A972C66182566BE284111CB8939
            61910D3EFB2CB2A398D9A93CB688C539A7B353D962EE15F1B64C2147C488AF88
            0B33B99C2C11DF12B1468A30952BE237E2D8540E33030014496C177058892236
            1131891F12E422E2E500E048095F71DC572CE0640BC49772494BCFE173131205
            741D962EDDD4DA9A41F7E464A5700402C300262B99C967D35DD252D399BC1C00
            16EFFC5932E2DAD24545B634B5B6B434343332FDAA50FF75F36F4ADCDB457A19
            F8B96710ADFF8BEDAFFCD21A0060CC896AB3F38B2DAE0A80CE2D00C8DDFB62D3
            380080A4A86F1DD7BFBA0F4D3C2F890241BA8DB1715656961197C3321217F40F
            FD4F87BFA1AFBE67243EEE8FF2D05D39F14C618A802EAE1B2B2D254DC8A767A4
            33591CBAE19F87F81F07FE751E06419C780E9FC313458489A68CCB4B10B59BC7
            E60AB8693C3A97F79F9AF80FC3FEA4C5B91689D2F81150638C80D4752A407EED
            07280A1120D1FBC55DFFA36FBEF830207E79E12A938B73FFEF37FD67C1A5E225
            839BF039CE252884CE12F23317F7C4CF12A0010148022A9007CA401DE8004360
            06AC802D70046EC01BF8831010095603164804A9800FB2401ED8040A4131D809
            F6806A50071A41336805C741273805CE834BE01AB8016E83FB60144C80676016
            BC060B10046121324481E421154813D287CC2006640FB941BE50101409C54209
            100F124279D066A8182A83AAA17AA819FA1E3A099D87AE4083D05D680C9A867E
            87DEC1084C82A9B012AC051BC30CD809F68143E0557002BC06CE850BE01D7025
            DC001F853BE0F3F035F8363C0A3F83E7108010111AA28A18220CC405F147A290
            78848FAC478A900AA4016945BA913EE426328ACC206F51181405454719A26C51
            9EA850140BB506B51E5582AA461D4675A07A51375163A859D4473419AD88D647
            DBA0BDD011E8047416BA105D816E42B7A32FA26FA327D0AF31180C0DA38DB1C2
            786222314998B59812CC3E4C1BE61C6610338E99C362B1F2587DAC1DD61FCBC4
            0AB085D82AEC51EC59EC107602FB0647C4A9E0CC70EEB8281C0F978FABC01DC1
            9DC10DE126710B7829BC26DE06EF8F67E373F0A5F8467C37FE3A7E02BF409026
            6813EC08218424C2264225A1957091F080F0924824AA11AD8981442E7123B192
            788C789938467C4B9221E9915C48D124216907E910E91CE92EE925994CD6223B
            92A3C802F20E7233F902F911F98D0445C248C24B822DB141A246A2436248E2B9
            245E5253D24972B564AE6485E409C9EB92335278292D291729A6D47AA91AA993
            52235273D2146953697FE954E912E923D257A4A764B0325A326E326C99029983
            321764C62908459DE242615136531A29172913540C559BEA454DA21653BFA30E
            506765656497C986C966CBD6C89E961DA521342D9A172D85564A3B4E1BA6BD5B
            A2B4C4690967C9F625AD4B8696CCCB2D957394E3C815C9B5C9DD967B274F9777
            934F96DF25DF29FF5001A5A0A710A890A5B05FE1A2C2CC52EA52DBA5ACA5454B
            8F2FBDA7082BEA290629AE553CA8D8AF38A7A4ACE4A194AE54A57441694699A6
            ECA89CA45CAE7C46795A85A262AFC255295739ABF2942E4B77A2A7D02BE9BDF4
            595545554F55A16ABDEA80EA829AB65AA85ABE5A9BDA4375823A433D5EBD5CBD
            477D564345C34F234FA345E39E265E93A199A8B957B34F735E4B5B2B5C6BAB56
            A7D694B69CB69776AE768BF6031DB28E83CE1A9D069D5BBA185D866EB2EE3EDD
            1B7AB09E855EA25E8DDE757D58DF529FABBF4F7FD0006D606DC0336830183124
            193A19661AB6188E19D18C7C8DF28D3A8D9E1B6B184719EF32EE33FE68626192
            62D26872DF54C6D4DB34DFB4DBF477333D3396598DD92D73B2B9BBF906F32EF3
            17CBF4977196ED5F76C78262E167B1D5A2C7E283A59525DFB2D572DA4AC32AD6
            AAD66A84416504304A1897ADD1D6CED61BAC4F59BFB5B1B411D81CB7F9CDD6D0
            36D9F688EDD472EDE59CE58DCBC7EDD4EC9876F576A3F674FB58FB03F6A30EAA
            0E4C870687C78EEA8E6CC726C749275DA724A7A34ECF9D4D9CF9CEEDCEF32E36
            2EEB5CCEB922AE1EAE45AE036E326EA16ED56E8FDCD5DC13DC5BDC673D2C3CD6
            7A9CF3447BFA78EEF21CF152F26279357BCD7A5B79AFF3EEF521F904FB54FB3C
            F6D5F3E5FB76FBC17EDE7EBBFD1EACD05CC15BD1E90FFCBDFC77FB3F0CD00E58
            13F06320263020B026F0499069505E505F30253826F848F0EB10E790D290FBA1
            3AA1C2D09E30C9B0E8B0E6B0F970D7F0B2F0D108E3887511D7221522B9915D51
            D8A8B0A8A6A8B9956E2BF7AC9C88B6882E8C1E5EA5BD2A7BD595D50AAB53569F
            8E918C61C69C8845C786C71E897DCFF4673630E7E2BCE26AE366592EACBDAC67
            6C4776397B9A63C729E34CC6DBC597C54F25D825EC4E984E7448AC489CE1BA70
            ABB92F923C93EA92E693FD930F257F4A094F694BC5A5C6A69EE4C9F09279BD69
            CA69D96983E9FAE985E9A36B6CD6EC5933CBF7E137654019AB32BA0454D1CF54
            BF5047B8453896699F5993F9262B2CEB44B674362FBB3F472F677BCE64AE7BEE
            B76B516B596B7BF254F336E58DAD735A57BF1E5A1FB7BE6783FA86820D131B3D
            361EDE44D894BCE9A77C93FCB2FC579BC337771728156C2C18DFE2B1A5A550A2
            905F38B2D5766BDD36D436EEB681EDE6DBABB67F2C62175D2D3629AE287E5FC2
            2AB9FA8DE93795DF7CDA11BF63A0D4B274FF4ECC4EDECEE15D0EBB0E974997E5
            968DEFF6DBDD514E2F2F2A7FB52766CF958A6515757B097B857B472B7D2BBBAA
            34AA7656BDAF4EACBE5DE35CD356AB58BBBD767E1F7BDFD07EC7FDAD754A75C5
            75EF0E700FDCA9F7A8EF68D06AA83888399879F049635863DFB78C6F9B9B149A
            8A9B3E1CE21D1A3D1C74B8B7D9AAB9F988E291D216B845D8327D34FAE88DEF5C
            BFEB6A356CAD6FA3B5151F03C784C79E7E1FFBFDF0719FE33D2718275A7FD0FC
            A1B69DD25ED40175E474CC7626768E7645760D9EF43ED9D36DDBDDFEA3D18F87
            4EA99EAA392D7BBAF40CE14CC1994F6773CFCE9D4B3F37733EE1FC784F4CCFFD
            0B11176EF506F60E5CF4B978F992FBA50B7D4E7D672FDB5D3E75C5E6CAC9AB8C
            AB9DD72CAF75F45BF4B7FF64F153FB80E540C775ABEB5D37AC6F740F2E1F3C33
            E43074FEA6EBCD4BB7BC6E5DBBBDE2F6E070E8F09D91E891D13BEC3B537753EE
            BEB897796FE1FEC607E807450FA51E563C527CD4F0B3EECF6DA396A3A7C75CC7
            FA1F073FBE3FCE1A7FF64BC62FEF270A9E909F544CAA4C364F994D9D9A769FBE
            F174E5D38967E9CF16660A7F95FEB5F6B9CEF31F7E73FCAD7F366276E205FFC5
            A7DF4B5ECABF3CF46AD9AB9EB980B947AF535F2FCC17BD917F73F82DE36DDFBB
            F077930B59EFB1EF2B3FE87EE8FEE8F3F1C1A7D44F9FFE050398F3FCBAC4E8D3
            000000097048597300000B0C00000B0C013F4022C8000007D64944415478DAD5
            990B50545518C7FFE7EE2E0F5D1014527CF4144A8D424A716C0451310DD39C4C
            7BEAA498CA9439653153424D62934D25BDB0075389199111669265A3419A96E0
            03CD207005525E414A1020ABB19D73EE3DF7B1EDBA3C9AB46FE7CEDEF3B8AFEF
            77FEDF77CEBDC4E17080D9D3EFCCCA20048B20CCA1FC13A7B2BECEB9DE8D190E
            25CEADBA0AE55E5C74522DD81A8A817D86A35F9FC1F0B5F879BEF82566CCDF44
            7BBE6ABAEDA1DBFA89132716F047671D56BD33EBA46421437DFC09CC1693EC0F
            22FB45E2C74A7299FD88B271BF891313C5AD44AD9388A4EEABAD92D893B43A02
            F59CACA7245FC8A59DAAAB437B5327E2C72462C4F0480458832FB67F7B651D1D
            1D686A6A82CD6683DD6E5F43A1AC225419EB89E4586A0DA6AE9098234D06274A
            92E6740006209AE7880C4FA128C372014471B6045D1B31B671E892A49C57D3D6
            993FFE40CB693B12E25E07696B46DFEF3360FFA9C0E3439B06872160C58717DB
            F717340A03C5C5C5686D6D9D4A9E7A7B665B9F40C9D7ECE3A0CE97F818D51B2B
            CBFE919DAEB8DB00823955EEA2B5A96AD2395A0FC024C013A59D68EA11A865F8
            4027557145793D16C5BD8A005327DA3E5C0E4B73AD67182161F05FB41EC4E7D2
            0E6DC7EB7210E43319870E1DCAA50A99E9B05EC6D421C736A110E114369AEF8C
            4AC6E541E18693EC3A968149A312F07D59160E566C938F959C612A4E16601480
            4C8A262785E834A9A8C808A4BCB406290B36A3FDAB97D079788B671883C2E037
            BF6B30E2E2E29090908079F3E619EA0F1E3C88A4A424AC5DBB169191912E8F4D
            4B4BE3FD3233337B04E340C51B38D9B80BB36ECE417E7E3E3810BF41ECF16585
            C021191CC5DC74D7B864BEFF5961AAE264B96DF9B42CEC2D97817057B298A74B
            C8A2AF1AE60CCED72B49773D9E67742AA15B27BDB7B2921AAC79E87334A74D86
            E36C8B7A0D4BF80C988745C2D1D182B33BD7C9F731300CD67BBAAE0C7740BA62
            BD0152687B0D550DBBF8FE9C715B14206FCB40645F121D10C52114D29CB13A20
            4407E4D62C592195DBB892F4C95880583665037E3CBE19C5BF6EC7D0FEA3705B
            C4E3D87EF815D4349518C0EB1522D2966873405648EA620AE495B11A8C9133E0
            3B2D85EF9F3F79006D9B97C1141C863E73290C6FF7309C01F406487676360A0A
            0A909E9EDEADE3CA6AF370A44ACB6D73C665E98084680A514727D1D2B60C8420
            470051720203B2B7FC632ABB2FF0C8D44DEAC99BDB7FC38EA36F62DCF0B91C82
            2B6B696FC09EB28D987EE363A8395382C181235074E2331C3BF58D065517B284
            425ADED080788D5D0C6FBA31EB6C2843C7FE77E13325E58230580862235A181B
            D9F3E7CF477474346A6B6B515E5E8E9090101EA65859842C56B77AF56ADECE2C
            3E3E1E2B56ACE040D8F9589FEED8E1CA4D749066ABE505D15BB590651D48F86C
            8A3B405188987D3248775220970FD072C8AFBF1F456EE1F378745A969A4378DC
            A732F3F6EA8B8498B770A82A8F2B63E9E40F6485546DC790FE23113F7A25F2A8
            42EA9A64080C48634B15BE3E9206FBF936431E12895ECE21B554215BD0FAFE04
            0D48C483B08C5ED8BD210DD70AB15AAD484E4EE68E6780587B6868A80A8481C8
            C8C8E04A60F5C27A0AE440C5261A59B2D4F2E2D86D468588C8416032C674FA13
            21EB420AB9E9AA99181FAA49FEE7EA6F5150F2811AB20E577D49818CC20C0144
            51C5F488C7F055F13AD43695CAD7E32A750FE4ECC628F51AE6F08530472CF957
            80B82AEB813050898989F0F3F3E36A62ED5D05D271BE15BB7E7A1963AEB91F41
            7E57F3BAA21359D46F9A42964C5672089DF63AFC19108815A404405B6BB024AB
            CF21FA84FCA892D43BCEB52176E422E497BC879F4F7D8BC4B88D1CC877A51B54
            85302043078C427CC44A7CC972080532C41310E54A2CA997D390954A43963D67
            BCFA10A6F087610ABBF73F012266590C405E5E1E5714538B27201DE7FEC4A785
            496868B6513FBE4843F80DBC7EC7D197A98FE4F0ECEBD50F4B26655F3887404D
            B114089DF6B262CEFE54DDC29029E4231EB258797CE8DDD8B8E771785BFA626E
            D473B0D5EFE77964614C3A4EFC5688DDA59908EE772566DF9C82DDBF64E2979A
            DD1A90233A20D0A9D5A01039A99FDB2AE71069D80C9846A7741B06B3D9B36723
            262686E780EE0261C6421703919B9BCBC1B8550685F1F10F4FA2A1C5C6CBB123
            9672FF9CA421FF58F50EB5DFB00137625ED48B6A0EA9A5EB90419ED621FF04A2
            CDB26C75FB312D62392EF3BF8A8E844A7A0315183924163F1CFF84F78BA2C99D
            59D6DE24445FB780E7127D5267406ACE947A5C873CFB600EFEDA190BCBE02990
            C29FE9110C31CA99539989A4EE0988C821C2447F77D3DEB314C6477B9F407DB3
            CDE3FD4CB8F6018CB9622EF6EDDB57CD14B2D92780CCB1F8C2AD429465B358DA
            69AB6AFD9495B8797FF52FADD459C8BA6FC20B086CCFC7A0C8653D86F15F1883
            B161CFCA2EC1F0B158F130CDB32D67DA51525292CD143289FA66A735886AC1C4
            D62162454D945996AB77591A18E757255A1FE3E24F0FA727EFB21A4F9FA6F3E9
            FEB87FEAB3F0F2F2426060E0C5F6BB5B4BDFB904755D803122E416DC4E238B97
            E4F757515191C96EB74F146F7B5389993CEDEB4F175BDE666D96A51BD9FAF756
            CE2F1785EB393CD5D1D23F81F4F26D6F757D3DACF62B307D4CA261EAF97F35E6
            FBC6C646545656B2178B6B68D52A22BE87AC7AF78E38FAB7956E3E4A77C39F4B
            2775E15B8873B7DE7E0F0909BC1E41E6A108B00E83B7B9AFFA7DC1E93BC3FFC2
            D8EB77AAF65C7ADFEB69914FB9FE0694BF657C0E6B0AB10000000049454E44AE
            426082}
          Visible = False
        end
        object vstView: TVirtualEditTree
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 472
          Height = 554
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Align = alClient
          BevelInner = bvNone
          BevelKind = bkSoft
          BorderStyle = bsNone
          ClipboardFormats.Strings = (
            'Plain text'
            'Virtual Tree Data')
          DragOperations = [doCopy]
          Header.AutoSizeIndex = 1
          Header.Height = 21
          Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoOwnerDraw, hoRestrictDrag, hoVisible]
          Header.ParentFont = True
          Header.PopupMenu = pmuViewHeader
          HintMode = hmTooltip
          HotCursor = crHandPoint
          LineStyle = lsCustomStyle
          NodeDataSize = 8
          ParentShowHint = False
          PopupMenu = pmuView
          SelectionBlendFactor = 24
          ShowHint = True
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toFullRowDrag, toEditOnClick]
          TreeOptions.PaintOptions = [toHotTrack, toShowHorzGridLines, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect, toSimpleDrawSelection]
          TreeOptions.StringOptions = [toAutoAcceptEditChange]
          OnAdvancedHeaderDraw = vstViewAdvancedHeaderDraw
          OnBeforeCellPaint = vstViewBeforeCellPaint
          OnBeforeItemErase = vstViewBeforeItemErase
          OnClick = vstViewClick
          OnCollapsing = vstViewCollapsing
          OnCreateEditor = vstViewCreateEditor
          OnDblClick = vstViewDblClick
          OnDragAllowed = vstViewDragAllowed
          OnDragOver = vstViewDragOver
          OnDragDrop = vstViewDragDrop
          OnEditing = vstViewEditing
          OnFocusChanged = vstViewFocusChanged
          OnFocusChanging = vstViewFocusChanging
          OnFreeNode = vstViewFreeNode
          OnGetText = vstViewGetText
          OnPaintText = vstViewPaintText
          OnGetHint = vstViewGetHint
          OnHeaderClick = vstViewHeaderClick
          OnHeaderDrawQueryElements = vstViewHeaderDrawQueryElements
          OnInitChildren = vstViewInitChildren
          OnInitNode = vstViewInitNode
          OnKeyDown = vstViewKeyDown
          OnNewText = vstViewNewText
          OnResize = vstViewResize
          Columns = <
            item
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coFixed]
              Position = 0
              Width = 250
              WideText = '标签'
            end
            item
              Position = 1
              Width = 220
              WideText = '数值'
            end>
        end
      end
      object tbsReferencedBy: TTabSheet
        Caption = '引用信息'
        ImageIndex = 3
        TabVisible = False
        OnShow = tbsViewShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lvReferencedBy: TListView
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 472
          Height = 554
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Align = alClient
          BevelInner = bvNone
          BevelKind = bkSoft
          BorderStyle = bsNone
          Columns = <
            item
              AutoSize = True
              Caption = '记录'
            end
            item
              AutoSize = True
              Caption = '文件'
            end>
          GridLines = True
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          PopupMenu = pmuRefBy
          TabOrder = 0
          ViewStyle = vsReport
          OnColumnClick = lvReferencedByColumnClick
          OnCompare = lvReferencedByCompare
          OnDblClick = lvReferencedByDblClick
        end
      end
      object tbsMessages: TTabSheet
        Caption = '日志'
        ImageIndex = 1
        OnShow = tbsMessagesShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object mmoMessages: TMemo
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 472
          Height = 554
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
          OnDblClick = mmoMessagesDblClick
        end
      end
      object tbsInfo: TTabSheet
        Caption = '信息'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Memo1: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 466
          Height = 551
          Align = alClient
          BorderStyle = bsNone
          Lines.Strings = (
            'TES5Edit 是一款可视化插件编辑器与冲突检测器。'
            ''
            '左半边以树状结构显示加载的所有插件，并且按照准确的加载顺序显示。'
            '通过修改树状结构的显示，你可以看到插件内部的所有细节部分。'
            ''
            
              '你只需要选择某个记录类型，该记录的详细信息将会在右边的列表中显示' +
              '。'
            
              '如果多个插件都修改到该记录类型，那么右边列表中也将显示全部插件关' +
              '于该记录类型的详细信息。'
            
              '最左边一列是 Master ，最右边一列则为游戏中“胜出”的部分。这也是' +
              '游戏引擎加载插件的方式。'
            ''
            
              '你会发现不论是左半边的树状结构或者右边的列表视窗都会有不同的颜色' +
              '，这些颜色可以用来突出标识插件的冲突信息。'
            ''
            '背景颜色：'
            '白色 - 独立的记录'
            '绿色 - 多种数值但是没有冲突'
            '黄色 - 覆盖但没有冲突'
            '红色 - 冲突'
            ''
            '文本颜色：'
            '黑色 - 独立的记录'
            '紫色 - Master'
            '灰色 - ITM 记录'
            '橙色 - ITM 记录但是是冲突的赢方'
            '绿色 - 覆盖但是不冲突'
            '橙色 - 冲突赢方'
            '红色 - 冲突败方'
            ''
            
              '冲突检测并不是存在的根据同一个表单序号在不同插件的记录的多样性来' +
              '判断，而是通过比较已解析的子记录的内容。'
            ''
            '左边树状结构的右键菜单中你可以启用筛选过滤器。'
            '筛选的方式是基于冲突的背景颜色和文本颜色。'
            ''
            
              '是的，筛选需要消耗一定的时间。每一个出现不止一次的记录，它都需要' +
              '编译并且比较记录的在每个插件的差异性。'
            ''
            '那么 ITM 记录是什么东西？'
            
              'ITM 即 Identical to Master，表示该记录与 Master 的记录完全一致，' +
              '一般为多余的内容，需要清理掉。'
            
              '在插件清理中，除了 ITM 记录，还经常会遇到 UDR ，即 Undelete and ' +
              'Disable References ，具体来说就是：恢复不小心删除的数据，然后再' +
              '让该数据不可用（避免变为 ITM ）。UDR 的存在会导致游戏退出时出错' +
              '，建议始终修复。'
            
              '关于 ITM、UDR 以及插件的清理可以参考以下教程：http://tesfans.org' +
              '/tes4edit-cleaning-quick-guide/'
            ''
            '论坛：http://forums.bethsoft.com/topic/1450501-relz-tes5edit/'
            '汉化版：http://tesfans.org/xedit/'
            ''
            
              '警告：此程序需要使用大量的内存。少于 2GB 内存是不怎么足够的。如' +
              '果使用了筛选过滤器，你需要的内存将更多。'
            ''
            '那么什么是 MOD 群组？'
            ''
            
              '这个的答案与“我安装了 FCOM 然后所有的记录都是红色的！我该怎么办' +
              '？”的答案是一样的，'
            ''
            
              '在 Mod 群组中，如果它们之间存在着大量的冲突警告，这时候你可以把' +
              '它们当成是没有冲突的。例：如果你安装了 FCOM 并且不想看到它们的冲' +
              '突，那么你可以定义一个 Mod 群组。Mod 群组保存在 TES4View.modgrou' +
              'ps ，安装在 TES4View.exe 附近。'
            
              '程序已内置部分 Mod 群组信息。这边只是举个例子，并不是说所有的冲' +
              '突都是无害或者你可以直接无视的。'
            ''
            
              '不是所有在文件中定义的 Mod 群组都有必要显示在选项列表中。已激活' +
              '插件少于2个时，Mod 群组是不会生效的。当前加载顺序与 Mod 群组中定' +
              '义的顺序不同时，Mod 群组同样不会生效。'
            ''
            '开启 Mod 群组回有什么效果？'
            ''
            
              '当记录完整加载并且在右边的详细窗口中显示时，你会看到同一 Mod 群' +
              '组的很多插件都修改了该项记录，但在 Mod 群组存在的情况下，仅 Mod ' +
              '群组中定义的最新文件会显示在列表中。此机制同样影响冲突的分类。'
            ''
            
              '值得指出的，Mod 群组中的插件与其他普通插件冲突时，冲突检测还是能' +
              '完美工作的。'
            ''
            '从根本上说，此机制可以用来避免冲突检测中出现大量混杂信息。'
            ''
            'TES%Edit 还有一个同胞兄弟：TES5Dump'
            ''
            'http://oblivion.nexusmods.com/mods/11484'
            ''
            '吐槽：他已经牺牲了……')
          ParentColor = True
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object tbsWEAPSpreadsheet: TTabSheet
        Caption = '武器记录表'
        ImageIndex = 4
        OnShow = tbsSpreadsheetShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object vstSpreadSheetWeapon: TVirtualEditTree
          Tag = 6
          Left = 0
          Top = 0
          Width = 472
          Height = 557
          Align = alClient
          Color = clInfoBk
          DragOperations = [doCopy]
          Header.AutoSizeIndex = 0
          Header.Options = [hoColumnResize, hoDblClickResize, hoRestrictDrag, hoShowSortGlyphs, hoVisible]
          Header.ParentFont = True
          Header.SortColumn = 1
          HintMode = hmTooltip
          HotCursor = crHandPoint
          IncrementalSearch = isAll
          ParentShowHint = False
          PopupMenu = pmuSpreadsheet
          SelectionBlendFactor = 32
          ShowHint = True
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toFullRowDrag]
          TreeOptions.PaintOptions = [toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMultiSelect, toRightClickSelect]
          TreeOptions.StringOptions = [toAutoAcceptEditChange]
          OnClick = vstSpreadSheetClick
          OnCompareNodes = vstSpreadSheetCompareNodes
          OnDragAllowed = vstSpreadSheetDragAllowed
          OnDragOver = vstSpreadSheetDragOver
          OnDragDrop = vstSpreadSheetDragDrop
          OnEditing = vstSpreadSheetEditing
          OnFreeNode = vstSpreadSheetFreeNode
          OnGetText = vstSpreadSheetGetText
          OnPaintText = vstSpreadSheetPaintText
          OnGetHint = vstSpreadSheetGetHint
          OnHeaderClick = vstNavHeaderClick
          OnIncrementalSearch = vstSpreadSheetIncrementalSearch
          OnInitNode = vstSpreadSheetWeaponInitNode
          OnNewText = vstSpreadSheetNewText
          Columns = <
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 0
              Width = 150
              WideText = '文件'
            end
            item
              MinWidth = 75
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 1
              Width = 75
              WideText = '表单序号'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 2
              Width = 150
              WideText = '编辑器标识'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 3
              Width = 150
              WideText = '名字'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 4
              Width = 150
              WideText = '附魔'
            end
            item
              MinWidth = 110
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 5
              Width = 110
              WideText = '类型'
            end
            item
              Alignment = taRightJustify
              MinWidth = 85
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 6
              Width = 85
              WideText = '速度'
            end
            item
              Alignment = taRightJustify
              MinWidth = 85
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 7
              Width = 85
              WideText = '范围'
            end
            item
              Alignment = taRightJustify
              MinWidth = 65
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 8
              Width = 65
              WideText = '价值'
            end
            item
              Alignment = taRightJustify
              MinWidth = 65
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 9
              Width = 65
              WideText = '生命'
            end
            item
              Alignment = taRightJustify
              MinWidth = 85
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 10
              Width = 85
              WideText = '重量'
            end
            item
              Alignment = taRightJustify
              MinWidth = 65
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 11
              Width = 65
              WideText = '伤害'
            end>
        end
      end
      object tbsARMOSpreadsheet: TTabSheet
        Caption = '盔甲记录表'
        ImageIndex = 5
        OnShow = tbsSpreadsheetShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object vstSpreadsheetArmor: TVirtualEditTree
          Tag = 7
          Left = 0
          Top = 0
          Width = 472
          Height = 557
          Align = alClient
          Color = clInfoBk
          DragOperations = [doCopy]
          Header.AutoSizeIndex = 0
          Header.Options = [hoColumnResize, hoDblClickResize, hoRestrictDrag, hoShowSortGlyphs, hoVisible]
          Header.ParentFont = True
          Header.SortColumn = 1
          HintMode = hmTooltip
          HotCursor = crHandPoint
          IncrementalSearch = isAll
          ParentShowHint = False
          PopupMenu = pmuSpreadsheet
          SelectionBlendFactor = 32
          ShowHint = True
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toFullRowDrag]
          TreeOptions.PaintOptions = [toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMultiSelect, toRightClickSelect]
          TreeOptions.StringOptions = [toAutoAcceptEditChange]
          OnClick = vstSpreadSheetClick
          OnCompareNodes = vstSpreadSheetCompareNodes
          OnDragAllowed = vstSpreadSheetDragAllowed
          OnDragOver = vstSpreadSheetDragOver
          OnDragDrop = vstSpreadSheetDragDrop
          OnEditing = vstSpreadSheetEditing
          OnFreeNode = vstSpreadSheetFreeNode
          OnGetText = vstSpreadSheetGetText
          OnPaintText = vstSpreadSheetPaintText
          OnGetHint = vstSpreadSheetGetHint
          OnHeaderClick = vstNavHeaderClick
          OnIncrementalSearch = vstSpreadSheetIncrementalSearch
          OnInitNode = vstSpreadsheetArmorInitNode
          OnNewText = vstSpreadSheetNewText
          Columns = <
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 0
              Width = 150
              WideText = '文件'
            end
            item
              MinWidth = 75
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 1
              Width = 75
              WideText = '表单序号'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 2
              Width = 150
              WideText = '编辑器标识'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 3
              Width = 150
              WideText = '名字'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 4
              Width = 150
              WideText = '附魔'
            end
            item
              MinWidth = 120
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 5
              Width = 120
              WideText = '位置'
            end
            item
              MinWidth = 110
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 6
              Width = 110
              WideText = '类型'
            end
            item
              Alignment = taRightJustify
              MinWidth = 85
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 7
              Width = 85
              WideText = '耐用'
            end
            item
              Alignment = taRightJustify
              MinWidth = 65
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 8
              Width = 65
              WideText = '价值'
            end
            item
              Alignment = taRightJustify
              MinWidth = 65
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 9
              Width = 65
              WideText = '生命'
            end
            item
              Alignment = taRightJustify
              MinWidth = 85
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 10
              Width = 85
              WideText = '重量'
            end>
        end
      end
      object tbsAMMOSpreadsheet: TTabSheet
        Caption = '弓箭记录表'
        ImageIndex = 6
        OnShow = tbsSpreadsheetShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object vstSpreadSheetAmmo: TVirtualEditTree
          Tag = 5
          Left = 0
          Top = 0
          Width = 472
          Height = 557
          Align = alClient
          Color = clInfoBk
          DragOperations = [doCopy]
          Header.AutoSizeIndex = 0
          Header.Options = [hoColumnResize, hoDblClickResize, hoRestrictDrag, hoShowSortGlyphs, hoVisible]
          Header.ParentFont = True
          Header.SortColumn = 1
          HintMode = hmTooltip
          HotCursor = crHandPoint
          IncrementalSearch = isAll
          ParentShowHint = False
          PopupMenu = pmuSpreadsheet
          SelectionBlendFactor = 32
          ShowHint = True
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toFullRowDrag]
          TreeOptions.PaintOptions = [toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMultiSelect, toRightClickSelect]
          TreeOptions.StringOptions = [toAutoAcceptEditChange]
          OnCompareNodes = vstSpreadSheetCompareNodes
          OnDragAllowed = vstSpreadSheetDragAllowed
          OnDragOver = vstSpreadSheetDragOver
          OnDragDrop = vstSpreadSheetDragDrop
          OnEditing = vstSpreadSheetEditing
          OnFreeNode = vstSpreadSheetFreeNode
          OnGetText = vstSpreadSheetGetText
          OnPaintText = vstSpreadSheetPaintText
          OnGetHint = vstSpreadSheetGetHint
          OnHeaderClick = vstNavHeaderClick
          OnIncrementalSearch = vstSpreadSheetIncrementalSearch
          OnInitNode = vstSpreadSheetAmmoInitNode
          OnNewText = vstSpreadSheetNewText
          Columns = <
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 0
              Width = 150
              WideText = '文件'
            end
            item
              MinWidth = 75
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 1
              Width = 75
              WideText = '表单序号'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 2
              Width = 150
              WideText = '编辑器标识'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 3
              Width = 150
              WideText = '名字'
            end
            item
              MinWidth = 150
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 4
              Width = 150
              WideText = '附魔'
            end
            item
              Alignment = taRightJustify
              MinWidth = 85
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 5
              Width = 85
              WideText = '速度'
            end
            item
              Alignment = taRightJustify
              MinWidth = 65
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 6
              Width = 65
              WideText = '价值'
            end
            item
              Alignment = taRightJustify
              MinWidth = 85
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 7
              Width = 85
              WideText = '重量'
            end
            item
              Alignment = taRightJustify
              MinWidth = 65
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 8
              Width = 65
              WideText = '伤害'
            end>
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'TabSheet2'
        ImageIndex = 7
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DisplayPanel: TPanel
          Left = 0
          Top = 0
          Width = 472
          Height = 557
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          OnResize = DisplayPanelResize
        end
      end
    end
  end
  object pnlTop: TPanel
    Left = 3
    Top = 3
    Width = 942
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object bnBack: TSpeedButton
      AlignWithMargins = True
      Left = 884
      Top = 3
      Width = 24
      Height = 24
      Action = acBack
      Align = alRight
      Flat = True
      Glyph.Data = {
        36090000424D3609000000000000360000002800000030000000100000000100
        18000000000000090000130B0000130B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF7F4026814125814125814125814125814125FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93939394949494
        9494949494949494949494FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF652814672913672913672913672913672913FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF824125814125CB6600CB6600CB
        6600CB6600CB6600CB6600814125814125FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF949494949494A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A19494949494
        94FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF682913672913BC4B00BC4B00BC
        4B00BC4B00BC4B00BC4B00672913672913FF00FFFF00FFFF00FFFF00FFFF00FF
        9B4E18C56203CA6500CA6500CA6500CA6500CA6500CB6600CB6600CB6600C563
        03814125FF00FFFF00FFFF00FFFF00FF989898A0A0A0A1A1A1A1A1A1A1A1A1A1
        A1A1A1A1A1A1A1A1A1A1A1A1A1A1A0A0A0949494FF00FFFF00FFFF00FFFF00FF
        83350BB54701BB4A00BB4A00BB4A00BB4A00BB4A00BC4B00BC4B00BC4B00B548
        01672913FF00FFFF00FFFF00FF994D19C46202C86300C66100C66100C66100C6
        6100C86300C96400CB6600CB6600CB6600C56303814125FF00FFFF00FF989898
        9F9F9FA0A0A09F9F9F9F9F9F9F9F9F9F9F9FA0A0A0A0A0A0A1A1A1A1A1A1A1A1
        A1A0A0A0949494FF00FFFF00FF81340CB44700B84800B64600B64600B64600B6
        4600B84800BA4900BC4B00BC4B00BC4B00B54801672913FF00FFFF00FFBB5D06
        C66201C46002C25E02BF5B02CE833FD6955AD8975BD68F4BD07720CB6600CB66
        00CB6600824125FF00FFFF00FF9D9D9D9F9F9F9F9F9F9E9E9E9D9D9DB8B8B8C4
        C4C4C5C5C5BFBFBFAEAEAEA1A1A1A1A1A1A1A1A1949494FF00FFFF00FFA94202
        B64700B44500B14300AD4100C06928CA7D40CC7F41CA7632C25C10BC4B00BC4B
        00BC4B00682913FF00FFA85411C96707C7680AC56809C26608C16405E7C3A0FE
        FEFEFEFEFEFEFEFEFEFEFEDB9957CB6600CB6600CB66007F40269A9A9AA3A3A3
        A3A3A3A2A2A2A1A1A19F9F9FE3E3E3FFFFFFFFFFFFFFFFFFFFFFFFC5C5C5A1A1
        A1A1A1A1A1A1A1939393923A07BA4C02B74D03B54D03B14B03B04901E0B289FE
        FEFEFEFEFEFEFEFEFEFEFED0813DBC4B00BC4B00BC4B00652814AC570FCD7114
        CA7218C8721AC7711AC56F17C56F18C6711CC46E1AC56D1EE4B78DFEFEFECA65
        00CB6600CB66008241259B9B9BA8A8A8A9A9A9A9A9A9A8A8A8A7A7A7A7A7A7A9
        A9A9A8A8A8A9A9A9DBDBDBFFFFFFA1A1A1A1A1A1A1A1A1949494973D06BF5609
        BB570BB8570CB7560CB5540AB5540BB6560DB4530CB5520FDCA474FEFEFEBB4A
        00BC4B00BC4B00682913AB5812D48434CF7F2ECD7E2DCD7F2FCC7D2CEACCACC6
        7019C2680CBF6003C66915FEFEFECA6500CB6600CB66008241259C9C9CB6B6B6
        B2B2B2B1B1B1B2B2B2B1B1B1E8E8E8A8A8A8A2A2A29E9E9EA6A6A6FFFFFFA1A1
        A1A1A1A1A1A1A1949494963E07C76A1FC1651ABF6419BF651BBD6318E3BD97B6
        550CB14D04AD4501B64E09FEFEFEBB4A00BC4B00BC4B00682913AC5915DEA264
        D7934DD38B41D48D44ECCFB1FEFEFECB7B2AC67019C3670BD7985DFEFEFECA65
        00CB6600CB66008241259D9D9DCBCBCBC0C0C0BBBBBBBCBCBCEAEAEAFFFFFFAF
        AFAFA8A8A8A2A2A2C6C6C6FFFFFFA1A1A1A1A1A1A1A1A1949494973F09D48B49
        CB7A34C67229C7742CE6C19DFEFEFEBC6017B6550CB24C04CB8042FEFEFEBB4A
        00BC4B00BC4B00682913AA5711E6B482E3B17CDA9854F4E0CCFEFEFEFEFEFEF8
        EEE3F3E1CFF2DFCCFEFEFEE5B88DCA6500CB6600CB66008241259B9B9BD8D8D8
        D4D4D4C4C4C4F7F7F7FFFFFFFFFFFFFFFFFFF8F8F8F6F6F6FFFFFFDCDCDCA1A1
        A1A1A1A1A1A1A1949494953D07DEA068DA9D62CF803AF0D7BDFEFEFEFEFEFEF6
        E9DAEFD8C1EED5BDFEFEFEDDA574BB4A00BC4B00BC4B00682913AA550EE7B27D
        F0D3B5E5B079F5E1CCFEFEFEFEFEFEF4E2D0EBCBABE9C7A4DB9E60C76303CA65
        00CB6600CB66007F40269A9A9AD7D7D7EDEDEDD4D4D4F7F7F7FFFFFFFFFFFFF8
        F8F8E8E8E8E5E5E5C8C8C8A1A1A1A1A1A1A1A1A1A1A1A1939393953B05E09E63
        EBC6A1DD9C5EF2D8BDFEFEFEFEFEFEF0D9C2E5BC96E2B78ED08745B74801BB4A
        00BC4B00BC4B00652814FF00FFAF6221F3D9BFF4D9BEEABB8BF2D8BDFEFEFED5
        8E45D08232CD7720CB6F11CA6604CA6500CB6600824125FF00FFFF00FFA3A3A3
        F2F2F2F2F2F2DCDCDCF1F1F1FFFFFFBDBDBDB4B4B4ACACACA7A7A7A2A2A2A1A1
        A1A1A1A1949494FF00FFFF00FF9A4711EFCEADF0CEACE3A972EECCABFEFEFEC9
        752DC2681DBF5C10BC5407BB4B01BB4A00BC4B00682913FF00FFFF00FFAA550E
        E9B782F8E7D5F6DFC8E9BB8BEFCFAED78F45D38433D07A22CF7417CB6808CB66
        00C563037D3F27FF00FFFF00FF9A9A9AD9D9D9FBFBFBF6F6F6DCDCDCEAEAEABD
        BDBDB6B6B6AFAFAFAAAAAAA3A3A3A1A1A1A0A0A0939393FF00FFFF00FF953B05
        E2A468F6E0C9F3D5B8E2A972EAC199CB762DC66A1EC25F11C1590ABC4D03BC4B
        00B54801632815FF00FFFF00FFFF00FFAB5610EBB986F6E0CAF7E6D4F0D1B1E8
        B98AE3AA71DFA060D98F44CE7111C563038F481EFF00FFFF00FFFF00FFFF00FF
        9B9B9BDBDBDBF7F7F7FAFAFAECECECDCDCDCD1D1D1C9C9C9BDBDBDA8A8A8A0A0
        A0969696FF00FFFF00FFFF00FFFF00FF963C06E5A66CF3D7BBF4DEC7EBC49DE1
        A670DA9556D58945CE762CC05607B54801762F0FFF00FFFF00FFFF00FFFF00FF
        FF00FFAC570FB36728ECBC8BF0CBA6EECAA4EABC8EE1A263D47E28B05C158945
        21FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BA6A6A6DDDDDDE8E8E8E7
        E7E7DEDEDECBCBCBB2B2B29E9E9E959595FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF973D069F4C16E6AA72EBBC90E9BB8EE3AA75D88B48C764169C41096F2D
        11FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAE5911B05D17B2
        611DB1601AB05B149C5019FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF9C9C9C9F9F9FA2A2A2A1A1A19E9E9E999999FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993F079C420A9E
        460E9D450C9C410984360CFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 3
      ExplicitLeft = 886
    end
    object bnForward: TSpeedButton
      AlignWithMargins = True
      Left = 914
      Top = 3
      Width = 25
      Height = 24
      Action = acForward
      Align = alRight
      Flat = True
      Glyph.Data = {
        36090000424D3609000000000000360000002800000030000000100000000100
        18000000000000090000130B0000130B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF7F4026814125814125814125814125814125FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93939394949494
        9494949494949494949494FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF652814672913672913672913672913672913FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF824125814125CB6600CB6600CB
        6600CB6600CB6600CB6600814125814125FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF949494949494A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A19494949494
        94FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF682913672913BC4B00BC4B00BC
        4B00BC4B00BC4B00BC4B00672913672913FF00FFFF00FFFF00FFFF00FFFF00FF
        9B4E18C56203CA6500CA6500CA6500CA6500CA6500CB6600CB6600CB6600C563
        03814125FF00FFFF00FFFF00FFFF00FF989898A0A0A0A1A1A1A1A1A1A1A1A1A1
        A1A1A1A1A1A1A1A1A1A1A1A1A1A1A0A0A0949494FF00FFFF00FFFF00FFFF00FF
        83350BB54701BB4A00BB4A00BB4A00BB4A00BB4A00BC4B00BC4B00BC4B00B548
        01672913FF00FFFF00FFFF00FF994D19C46202C86300C66100C66100C66100C6
        6100C86300C96400CB6600CB6600CB6600C56303814125FF00FFFF00FF989898
        9F9F9FA0A0A09F9F9F9F9F9F9F9F9F9F9F9FA0A0A0A0A0A0A1A1A1A1A1A1A1A1
        A1A0A0A0949494FF00FFFF00FF81340CB44700B84800B64600B64600B64600B6
        4600B84800BA4900BC4B00BC4B00BC4B00B54801672913FF00FFFF00FFBB5D06
        C66201C46002C25E02C76F22D18A4BD6955BD8965AD4883FC96400CB6600CB66
        00CB6600824125FF00FFFF00FF9D9D9D9F9F9F9F9F9F9F9F9FABABABBEBEBEC5
        C5C5C5C5C5BABABAA0A0A0A1A1A1A1A1A1A1A1A1949494FF00FFFF00FFA94202
        B64700B44500B14300B75411C47032CA7D41CC7E40C76E28BA4900BC4B00BC4B
        00BC4B00682913FF00FFA85411C96707C7680AC56809D69A5CFEFEFEFEFEFEFE
        FEFEFEFEFEE7C29FC66100C96400CB6600CB6600CB66007F40269B9B9BA3A3A3
        A3A3A3A2A2A2C5C5C5FFFFFFFFFFFFFFFFFFFFFFFFE3E3E39F9F9FA0A0A0A1A1
        A1A1A1A1A1A1A1939393923A07BA4C02B74D03B54D03CA8241FEFEFEFEFEFEFE
        FEFEFEFEFEE0B188B64600BA4900BC4B00BC4B00BC4B00652814AC570FCD7114
        CA7218C8721AFEFEFEE5BF98CA7C2CC77320C36B16C05F08C35E00C86300CA65
        00CB6600CB66008241259B9B9BA9A9A9A9A9A9A9A9A9FFFFFFDFDFDFB0B0B0AB
        ABABA6A6A6A0A0A09E9E9EA0A0A0A1A1A1A1A1A1A1A1A1949494973D06BF5609
        BB570BB8570CFEFEFEDDAD80BB6218B75810B2500AAF4403B24300B84800BB4A
        00BC4B00BC4B00682913AB5812D48434CF7F2ECD7E2DFEFEFED0873CCA7825C6
        7019C2680CE6C3A0C15C01C66100CA6500CB6600CB66008241259C9C9CB7B7B7
        B2B2B2B2B2B2FFFFFFB8B8B8ADADADA8A8A8A2A2A2E3E3E39E9E9E9F9F9FA1A1
        A1A1A1A1A1A1A1949494963E07C76A1FC1651ABF6419FEFEFEC26D25BB5D13B6
        550CB14D04DEB289B04100B64600BB4A00BC4B00BC4B00682913AC5915DEA264
        D7934DD38B41FEFEFEE2B484D08537CB7B2AC67019FEFEFEE5BE98C56000CA65
        00CB6600CB66008241259D9D9DCBCBCBC0C0C0BBBBBBFFFFFFD8D8D8B6B6B6B0
        B0B0A8A8A8FFFFFFDFDFDF9F9F9FA1A1A1A1A1A1A1A1A1949494973F09D48B49
        CB7A34C67229FEFEFED9A06AC26B21BC6017B6550CFEFEFEDDAC80B54500BB4A
        00BC4B00BC4B00682913AA5711E6B482E3B17CDA9854EFD2B5FEFEFEF5E6D7F4
        E4D3F7ECE1FEFEFEFEFEFEEDCFB2CA6500CB6600CB66008241259B9B9BD8D8D8
        D5D5D5C4C4C4EDEDEDFFFFFFFBFBFBF9F9F9FFFFFFFFFFFFFFFFFFEBEBEBA1A1
        A1A1A1A1A1A1A1949494953D07DEA068DA9D62CF803AEAC5A1FEFEFEF2DECBF0
        DCC6F4E6D8FEFEFEFEFEFEE7C19EBB4A00BC4B00BC4B00682913AA550EE7B27D
        F0D3B5E5B079E3AA6FEAC39AF0D6BBEDD0B3F2DFCBFEFEFEFEFEFEEBC8A6CA65
        00CB6600CB66007F40269B9B9BD7D7D7EDEDEDD5D5D5D1D1D1E2E2E2EFEFEFEC
        ECECF6F6F6FFFFFFFFFFFFE6E6E6A1A1A1A1A1A1A1A1A1939393953B05E09E63
        EBC6A1DD9C5EDA9554E3B282EBCAA9E7C29FEED5BCFEFEFEFEFEFEE5B890BB4A
        00BC4B00BC4B00652814FF00FFAF6221F3D9BFF4D9BEEABB8BE3AA6FDC9B5AD5
        8E45D08232FEFEFEE7BD92CA6604CA6500CB6600824125FF00FFFF00FFA3A3A3
        F2F2F2F2F2F2DDDDDDD1D1D1C7C7C7BDBDBDB4B4B4FFFFFFDEDEDEA2A2A2A1A1
        A1A1A1A1949494FF00FFFF00FF9A4711EFCEADF0CEACE3A972DA9554D18340C9
        752DC2681DFEFEFEE0AB79BB4B01BB4A00BC4B00682913FF00FFFF00FFAA550E
        E9B782F8E7D5F6DFC8E9BB8BDE9F5ED78F45D38433E7BC90CF7417CB6808CB66
        00C563037D3F27FF00FFFF00FF9B9B9BD9D9D9FBFBFBF6F6F6DDDDDDC9C9C9BE
        BEBEB6B6B6DDDDDDABABABA4A4A4A1A1A1A0A0A0939393FF00FFFF00FF953B05
        E2A468F6E0C9F3D5B8E2A972D48843CB762DC66A1EE0AA77C1590ABC4D03BC4B
        00B54801632815FF00FFFF00FFFF00FFAB5610EBB986F6E0CAF7E6D4F0D1B1E8
        B98AE3AA71DFA060D98F44CE7111C563038F481EFF00FFFF00FFFF00FFFF00FF
        9B9B9BDBDBDBF7F7F7FBFBFBECECECDCDCDCD1D1D1CACACABEBEBEA8A8A8A0A0
        A0969696FF00FFFF00FFFF00FFFF00FF963C06E5A66CF3D7BBF4DEC7EBC49DE1
        A670DA9556D58945CE762CC05607B54801762F0FFF00FFFF00FFFF00FFFF00FF
        FF00FFAC570FB36728ECBC8BF0CBA6EECAA4EABC8EE1A263D47E28B05C158945
        21FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BA6A6A6DDDDDDE8E8E8E7
        E7E7DEDEDECCCCCCB2B2B29F9F9F969696FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF973D069F4C16E6AA72EBBC90E9BB8EE3AA75D88B48C764169C41096F2D
        11FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAE5911B05D17B2
        611DB1601AB05B149C5019FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF9D9D9D9F9F9FA2A2A2A1A1A19F9F9F999999FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993F079C420A9E
        460E9D450C9C410984360CFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 3
      ExplicitLeft = 916
    end
    object lblPath: TEdit
      AlignWithMargins = True
      Left = 0
      Top = 5
      Width = 878
      Height = 20
      Margins.Left = 0
      Margins.Top = 5
      Margins.Bottom = 5
      Align = alClient
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkTile
      BevelWidth = 2
      BorderStyle = bsNone
      Ctl3D = True
      ParentColor = True
      ParentCtl3D = False
      PopupMenu = pmuPath
      ReadOnly = True
      TabOrder = 0
      Visible = False
    end
  end
  object pnlNav: TPanel
    Left = 3
    Top = 33
    Width = 455
    Height = 587
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
    object vstNav: TVirtualEditTree
      Left = 0
      Top = 25
      Width = 455
      Height = 562
      Align = alClient
      BevelInner = bvNone
      Colors.SelectionRectangleBlendColor = clGray
      Colors.SelectionRectangleBorderColor = clBlack
      Header.AutoSizeIndex = 2
      Header.Height = 21
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      Header.ParentFont = True
      Header.PopupMenu = pmuNavHeaderPopup
      Header.SortColumn = 0
      HintMode = hmTooltip
      IncrementalSearch = isVisibleOnly
      NodeDataSize = 8
      ParentShowHint = False
      SelectionBlendFactor = 32
      SelectionCurveRadius = 3
      ShowHint = True
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSort, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoFreeOnCollapse]
      TreeOptions.MiscOptions = [toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.PaintOptions = [toPopupMode, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
      TreeOptions.SelectionOptions = [toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toRightClickSelect]
      TreeOptions.StringOptions = [toShowStaticText, toAutoAcceptEditChange]
      OnBeforeItemErase = vstNavBeforeItemErase
      OnChange = vstNavChange
      OnCompareNodes = vstNavCompareNodes
      OnExpanding = vstNavExpanding
      OnFreeNode = vstNavFreeNode
      OnGetText = vstNavGetText
      OnPaintText = vstNavPaintText
      OnHeaderClick = vstNavHeaderClick
      OnIncrementalSearch = vstNavIncrementalSearch
      OnInitChildren = vstNavInitChildren
      OnInitNode = vstNavInitNode
      OnKeyDown = vstNavKeyDown
      Columns = <
        item
          Position = 0
          Width = 201
          WideText = '表单序号'
        end
        item
          Position = 1
          Width = 125
          WideText = '编辑器标识'
        end
        item
          Position = 2
          Width = 125
          WideText = '名字'
        end>
    end
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 455
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 150
        Height = 25
        Align = alLeft
        AutoSize = True
        BevelOuter = bvNone
        Padding.Left = 3
        Padding.Right = 3
        Padding.Bottom = 3
        TabOrder = 0
        object edFormIDSearch: TLabeledEdit
          Left = 68
          Top = 0
          Width = 79
          Height = 21
          EditLabel.Width = 62
          EditLabel.Height = 13
          EditLabel.Caption = '表单序号(&F)'
          LabelPosition = lpLeft
          TabOrder = 0
          OnChange = edFormIDSearchChange
          OnEnter = edFormIDSearchEnter
          OnKeyDown = edFormIDSearchKeyDown
        end
      end
      object Panel4: TPanel
        Left = 150
        Top = 0
        Width = 305
        Height = 25
        Align = alClient
        BevelOuter = bvNone
        Padding.Left = 3
        Padding.Right = 3
        Padding.Bottom = 3
        TabOrder = 1
        DesignSize = (
          305
          25)
        object edEditorIDSearch: TLabeledEdit
          Left = 80
          Top = 0
          Width = 291
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 74
          EditLabel.Height = 13
          EditLabel.Caption = '编辑器标识(&E)'
          LabelPosition = lpLeft
          TabOrder = 0
          OnChange = edEditorIDSearchChange
          OnEnter = edEditorIDSearchEnter
          OnKeyDown = edEditorIDSearchKeyDown
        end
      end
    end
  end
  object tmrStartup: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrStartupTimer
    Left = 56
    Top = 496
  end
  object tmrMessages: TTimer
    Interval = 500
    OnTimer = tmrMessagesTimer
    Left = 56
    Top = 544
  end
  object pmuNav: TPopupMenu
    OnPopup = pmuNavPopup
    Left = 152
    Top = 136
    object mniNavCompareTo: TMenuItem
      Caption = '比较...'
      OnClick = mniNavCompareToClick
    end
    object mniNavCompareSelected: TMenuItem
      Caption = '比较所选'
      OnClick = mniNavCompareSelectedClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mniNavFilterRemove: TMenuItem
      Caption = '移除筛选'
      OnClick = mniNavFilterRemoveClick
    end
    object mniNavFilterApply: TMenuItem
      Caption = '应用筛选'
      OnClick = mniNavFilterApplyClick
    end
    object mniNavFilterForCleaning: TMenuItem
      Caption = '应用清理筛选'
      OnClick = mniNavFilterForCleaningClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mniNavCheckForErrors: TMenuItem
      Caption = '检查错误'
      OnClick = mniNavCheckForErrorsClick
    end
    object mniNavCheckForCircularLeveledLists: TMenuItem
      Caption = '检查循环等级列表'
      OnClick = mniNavCheckForCircularLeveledListsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mniNavChangeFormID: TMenuItem
      Caption = '修改表单序号'
      OnClick = mniNavChangeFormIDClick
    end
    object mniNavChangeReferencingRecords: TMenuItem
      Caption = '修改引用记录'
      OnClick = mniNavChangeReferencingRecordsClick
    end
    object mniNavRenumberFormIDsFrom: TMenuItem
      Caption = '重新编号表单序号并起始于...'
      OnClick = mniNavRenumberFormIDsFromClick
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object mniNavApplyScript: TMenuItem
      Caption = '应用脚本'
      OnClick = mniNavApplyScriptClick
    end
    object mniNavBatchChangeReferencingRecords: TMenuItem
      Caption = '批量修改引用记录'
      OnClick = mniNavBatchChangeReferencingRecordsClick
    end
    object mniNavUndeleteAndDisableReferences: TMenuItem
      Caption = '修复 UDR 记录'
      OnClick = mniNavUndeleteAndDisableReferencesClick
    end
    object mniNavRemoveIdenticalToMaster: TMenuItem
      Caption = '移除 ITM 记录'
      OnClick = mniNavRemoveIdenticalToMasterClick
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object mniNavSetVWDAuto: TMenuItem
      Caption = '给文件中所有含远景模型的 REFR 设置远景'
      OnClick = mniNavSetVWDAutoClick
    end
    object mniNavSetVWDAutoInto: TMenuItem
      Caption = '给所有含远景模型的 REFR 设置远景并作为覆盖内容到...'
      OnClick = mniNavSetVWDAutoIntoClick
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object mniNavCellChildTemp: TMenuItem
      Caption = 'Temporary'
      GroupIndex = 1
      RadioItem = True
      OnClick = mniNavCellChild
    end
    object mniNavCellChildPers: TMenuItem
      Caption = 'Persistent'
      GroupIndex = 2
      RadioItem = True
      OnClick = mniNavCellChild
    end
    object mniNavCellChildNotVWD: TMenuItem
      Caption = '远景不可见'
      GroupIndex = 3
      OnClick = mniNavCellChild
    end
    object mniNavCellChildVWD: TMenuItem
      Caption = '远景可见'
      GroupIndex = 4
      OnClick = mniNavCellChild
    end
    object N5: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavAdd: TMenuItem
      Caption = '添加'
      GroupIndex = 4
      OnClick = mniNavAddClick
    end
    object mniNavRemove: TMenuItem
      Caption = '移除'
      GroupIndex = 4
      OnClick = mniNavRemoveClick
    end
    object mniNavMarkModified: TMenuItem
      Caption = '标记为已修改'
      GroupIndex = 4
      OnClick = mniNavMarkModifiedClick
    end
    object N6: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavAddMasters: TMenuItem
      Caption = '添加 Master...'
      GroupIndex = 4
      OnClick = mniNavAddMastersClick
    end
    object mniNavSortMasters: TMenuItem
      Caption = '调整 Master 顺序'
      GroupIndex = 4
      OnClick = mniNavSortMastersClick
    end
    object mniNavCleanMasters: TMenuItem
      Caption = '清理 Master'
      GroupIndex = 4
      OnClick = mniNavCleanMastersClick
    end
    object N4: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavCopyAsOverride: TMenuItem
      Caption = '复制为覆盖记录到...'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavDeepCopyAsOverride: TMenuItem
      Caption = '深度复制为覆盖记录到...'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCopyAsNewRecord: TMenuItem
      Caption = '复制为新记录到...'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCopyAsSpawnRateOverride: TMenuItem
      Caption = '复制为覆盖记录（刷新频率插件）到...'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCopyAsWrapper: TMenuItem
      Caption = '复制为封装器到...'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCleanupInjected: TMenuItem
      Caption = '清理注入到记录中的引用'
      GroupIndex = 4
      OnClick = mniNavCleanupInjectedClick
    end
    object mniNavCopyIdle: TMenuItem
      Caption = '复制 Idle 动作到...'
      GroupIndex = 4
      OnClick = mniNavCopyIdleClick
    end
    object N10: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavHidden: TMenuItem
      AutoCheck = True
      Caption = '隐藏'
      GroupIndex = 4
      OnClick = mniNavHiddenClick
    end
    object N16: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavTest: TMenuItem
      Caption = '测试'
      GroupIndex = 4
      OnClick = mniNavTestClick
    end
    object mniNavBanditFix: TMenuItem
      Caption = '强盗修复'
      GroupIndex = 4
      Visible = False
      OnClick = mniNavBanditFixClick
    end
    object mniNavOther: TMenuItem
      Caption = '其他'
      GroupIndex = 4
      object mniNavCreateMergedPatch: TMenuItem
        Caption = '创建整合补丁'
        GroupIndex = 4
        OnClick = mniNavCreateMergedPatchClick
      end
      object mniNavCreateSEQFile: TMenuItem
        Caption = '创建 SEQ 文件'
        GroupIndex = 4
        OnClick = mniNavCreateSEQFileClick
      end
      object mniNavBuildRef: TMenuItem
        Caption = '生成引用信息'
        GroupIndex = 4
        OnClick = mniNavBuildRefClick
      end
      object mniNavBuildReachable: TMenuItem
        Caption = '生成可用信息'
        GroupIndex = 4
        OnClick = mniNavBuildReachableClick
      end
      object mniNavGenerateObjectLOD: TMenuItem
        Caption = '生成对象 LOD'
        GroupIndex = 4
        OnClick = mniNavGenerateObjectLODClick
      end
      object mniNavRaceLVLIs: TMenuItem
        Caption = '修复种族特定 LVLI'
        GroupIndex = 4
        Visible = False
        OnClick = mniNavRaceLVLIsClick
      end
      object mniNavLocalization: TMenuItem
        Caption = '插件本地化'
        GroupIndex = 4
        object mniNavLocalizationEditor: TMenuItem
          Caption = '编辑器'
          GroupIndex = 4
          OnClick = mniNavLocalizationEditorClick
        end
        object mniNavLocalizationSwitch: TMenuItem
          Caption = '本地化'
          GroupIndex = 4
          OnClick = mniNavLocalizationSwitchClick
        end
        object mniNavLocalizationLanguage: TMenuItem
          Caption = '语言'
          GroupIndex = 4
        end
      end
      object mniNavLogAnalyzer: TMenuItem
        Caption = '日志分析器'
        GroupIndex = 4
      end
      object N13: TMenuItem
        Caption = '-'
        GroupIndex = 4
      end
      object mniNavOptions: TMenuItem
        Caption = '选项'
        GroupIndex = 4
        OnClick = mniNavOptionsClick
      end
    end
  end
  object pmuView: TPopupMenu
    OnPopup = pmuViewPopup
    Left = 760
    Top = 216
    object mniViewEdit: TMenuItem
      Caption = '编辑'
      OnClick = mniViewEditClick
    end
    object mniViewRemove: TMenuItem
      Caption = '移除'
      OnClick = mniViewRemoveClick
    end
    object mniViewRemoveFromSelected: TMenuItem
      Caption = '从所选记录中移除'
      OnClick = mniViewRemoveFromSelectedClick
    end
    object mniViewAdd: TMenuItem
      Caption = '添加'
      OnClick = mniViewAddClick
    end
    object mniViewNextMember: TMenuItem
      Caption = '下一个成员'
      OnClick = mniViewNextMemberClick
    end
    object mniViewPreviousMember: TMenuItem
      Caption = '上一个成员'
      OnClick = mniViewPreviousMemberClick
    end
    object mniViewCopyToSelectedRecords: TMenuItem
      Caption = '复制到所选记录'
      OnClick = mniViewCopyToSelectedRecordsClick
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object mniViewMoveUp: TMenuItem
      Caption = '上移(&U)'
      OnClick = mniViewMoveUpClick
    end
    object mniViewMoveDown: TMenuItem
      Caption = '下移(&D)'
      OnClick = mniViewMoveDownClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object mniViewSort: TMenuItem
      Caption = '按行排列'
      OnClick = mniViewSortClick
    end
    object mniViewCompareReferencedRow: TMenuItem
      Caption = '比较本行中引用的记录'
      OnClick = mniViewCompareReferencedRowClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object mniViewHideNoConflict: TMenuItem
      Caption = '隐藏无冲突行'
      OnClick = mniViewHideNoConflictClick
    end
    object ColumnWidths1: TMenuItem
      Caption = '列宽度'
      object mniViewColumnWidthStandard: TMenuItem
        AutoCheck = True
        Caption = '标准'
        RadioItem = True
        OnClick = mniViewColumnWidthClick
      end
      object mniViewColumnWidthFitAll: TMenuItem
        AutoCheck = True
        Caption = '适应所有'
        RadioItem = True
        OnClick = mniViewColumnWidthClick
      end
      object mniViewColumnWidthFitText: TMenuItem
        AutoCheck = True
        Caption = '适应文本'
        RadioItem = True
        OnClick = mniViewColumnWidthClick
      end
    end
  end
  object ActionList1: TActionList
    Left = 368
    Top = 88
    object acBack: TAction
      OnExecute = acBackExecute
      OnUpdate = acBackUpdate
    end
    object acForward: TAction
      OnExecute = acForwardExecute
      OnUpdate = acForwardUpdate
    end
    object acScript: TAction
      Caption = 'acScript'
      OnExecute = acScriptExecute
    end
  end
  object odModule: TOpenDialog
    Filter = '插件 (*.esm;*.esp;*.esu)|*.esm;*.esp;*.esu|所有文件 (*.*)|*.*'
    Options = [ofReadOnly, ofPathMustExist, ofFileMustExist, ofNoTestFileCreate, ofEnableSizing]
    Left = 352
    Top = 384
  end
  object pmuSpreadsheet: TPopupMenu
    OnPopup = pmuSpreadsheetPopup
    Left = 680
    Top = 616
    object mniSpreadsheetCompareSelected: TMenuItem
      Caption = '比较所选文件'
      OnClick = mniSpreadsheetCompareSelectedClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object mniSpreadsheetRebuild: TMenuItem
      Caption = '重建'
      OnClick = mniSpreadsheetRebuildClick
    end
  end
  object pmuViewHeader: TPopupMenu
    OnPopup = pmuViewHeaderPopup
    Left = 680
    Top = 48
    object mniViewHeaderCopyAsOverride: TMenuItem
      Caption = '复制为覆盖记录到...'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderCopyAsNewRecord: TMenuItem
      Caption = '复制为新记录到...'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderCopyAsWrapper: TMenuItem
      Caption = '复制为封装器到...'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderRemove: TMenuItem
      Caption = '移除'
      OnClick = mniViewHeaderRemoveClick
    end
    object mniViewHeaderJumpTo: TMenuItem
      Caption = '跳到'
      OnClick = mniViewHeaderJumpToClick
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object mniViewHeaderHidden: TMenuItem
      AutoCheck = True
      Caption = '隐藏'
      OnClick = mniViewHeaderHiddenClick
    end
  end
  object tmrCheckUnsaved: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = tmrCheckUnsavedTimer
    Left = 56
    Top = 400
  end
  object pmuNavHeaderPopup: TPopupMenu
    Left = 152
    Top = 88
    object Files1: TMenuItem
      Caption = '文件'
      object mniNavHeaderFilesDefault: TMenuItem
        AutoCheck = True
        Caption = '按照所选'
        Checked = True
        RadioItem = True
        OnClick = mniNavHeaderFilesClick
      end
      object mniNavHeaderFilesLoadOrder: TMenuItem
        AutoCheck = True
        Caption = '始终按照插件加载顺序'
        RadioItem = True
        OnClick = mniNavHeaderFilesClick
      end
      object mniNavHeaderFilesFileName: TMenuItem
        AutoCheck = True
        Caption = '始终按照文件名'
        RadioItem = True
        OnClick = mniNavHeaderFilesClick
      end
    end
  end
  object odCSV: TOpenDialog
    Filter = 'CSV (*.csv)|*.csv|所有文件 (*.*)|*.*'
    Options = [ofReadOnly, ofPathMustExist, ofFileMustExist, ofNoTestFileCreate, ofEnableSizing]
    Left = 352
    Top = 440
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 368
    Top = 152
  end
  object pmuRefBy: TPopupMenu
    OnPopup = pmuRefByPopup
    Left = 760
    Top = 160
    object mniRefByNotVWD: TMenuItem
      Caption = '远景不可见'
      OnClick = mniRefByVWDClick
    end
    object mniRefByVWD: TMenuItem
      Caption = '远景可见'
      OnClick = mniRefByVWDClick
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object mniRefByCopyOverrideInto: TMenuItem
      Caption = '复制为覆盖记录到...'
      OnClick = mniRefByCopyIntoClick
    end
    object mniRefByDeepCopyOverrideInto: TMenuItem
      Caption = '深度复制为覆盖记录到...'
      OnClick = mniRefByCopyIntoClick
    end
    object mniRefByCopyAsNewInto: TMenuItem
      Caption = '复制为新记录到...'
      OnClick = mniRefByCopyIntoClick
    end
    object mniRefByCopyDisabledOverrideInto: TMenuItem
      Caption = '复制为已禁止的覆盖记录到...'
      OnClick = mniRefByCopyDisabledOverrideIntoClick
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object mniRefByRemove: TMenuItem
      Caption = '移除'
      OnClick = mniRefByRemoveClick
    end
    object mniRefByMarkModified: TMenuItem
      Caption = '标记为已修改'
      OnClick = mniRefByMarkModifiedClick
    end
  end
  object pmuPath: TPopupMenu
    OnPopup = pmuPathPopup
    Left = 512
    object mniPathPluggyLink: TMenuItem
      Caption = 'Pluggy 链接'
      object mniPathPluggyLinkDisabled: TMenuItem
        Caption = '关闭'
        Checked = True
        RadioItem = True
        OnClick = mniPathPluggyLinkClick
      end
      object mniPathPluggyLinkReference: TMenuItem
        Tag = 1
        Caption = '引用'
        RadioItem = True
        OnClick = mniPathPluggyLinkClick
      end
      object mniPathPluggyLinkBaseObject: TMenuItem
        Tag = 2
        Caption = '基础对象'
        RadioItem = True
        OnClick = mniPathPluggyLinkClick
      end
      object mniPathPluggyLinkInventory: TMenuItem
        Caption = '装备'
        RadioItem = True
        OnClick = mniPathPluggyLinkClick
      end
      object mniPathPluggyLinkEnchantment: TMenuItem
        Caption = '附魔'
        RadioItem = True
        OnClick = mniPathPluggyLinkClick
      end
      object mniPathPluggyLinkSpell: TMenuItem
        Caption = '魔法'
        RadioItem = True
        OnClick = mniPathPluggyLinkClick
      end
    end
  end
  object pmuNavAdd: TPopupMenu
    Left = 152
    Top = 184
  end
  object tmrGenerator: TTimer
    Enabled = False
    OnTimer = tmrGeneratorTimer
    Left = 56
    Top = 448
  end
end
