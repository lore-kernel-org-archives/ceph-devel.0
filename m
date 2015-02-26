From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: MDS crashes (80.8)
Date: Thu, 26 Feb 2015 13:27:34 -0500
Message-ID: <CAGbvivLaKuOq999tC3OWnwOJrq1Hf4FVnbvCESdMPGbfCetZsA@mail.gmail.com>
References: <CAGbvivJQYb6KpZPW0ug_q7rbL_NYB2eGS+Vcktvy_W3ECHxKbA@mail.gmail.com>
	<54EF527B.8060403@redhat.com>
	<CAGbvivK+oHAfD3bURzDyRDsoBtKtmp35ZZ-YC7kLyLXD6mQ6fQ@mail.gmail.com>
	<54EF5CF0.3030503@redhat.com>
	<CAGbvivKiuJ1UrACb2W_fX+8TFDvJ0XrayGYXjL3qGRWZMCPSYg@mail.gmail.com>
	<54EF5F6C.8030305@redhat.com>
	<CAGbvivL_5TDYXPbz6Pu7OKrU3WdATY0CY5qDTgUs-qSqwQvX7g@mail.gmail.com>
	<54EF637A.7030906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:41736 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbbBZS1f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 13:27:35 -0500
Received: by mail-oi0-f53.google.com with SMTP id u20so11071025oif.12
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 10:27:35 -0800 (PST)
In-Reply-To: <54EF637A.7030906@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: ceph-devel@vger.kernel.org

Excellent, thanks.

It starts now without crashing, but I see lots of errors like this:

2015-02-26 08:24:19.134693 7f78091aa700  0 cephx: verify_reply
couldn't decrypt with error: error decoding block for decryption
2015-02-26 08:24:19.134695 7f78091aa700  0 -- 10.2.3.33:6800/5236 >>
10.2.2.104:6857/8883 pipe(0x26f5700 sd=33 :50680 s=1 pgs=0 cs=0 l=1
c=0x280b1e0).failed verifying authorize reply
2015-02-26 08:24:19.134717 7f7809bb4700  0 cephx: verify_reply
couldn't decrypt with error: error decoding block for decryption
2015-02-26 08:24:19.134719 7f7809bb4700  0 -- 10.2.3.33:6800/5236 >>
10.2.3.111:6848/4652 pipe(0x26f4300 sd=23 :58785 s=1 pgs=0 cs=0 l=1
c=0x2694c00).failed verifying authorize reply
2015-02-26 08:24:19.134761 7f78093ac700  0 cephx: verify_reply
couldn't decrypt with error: error decoding block for decryption
2015-02-26 08:24:19.134764 7f78093ac700  0 -- 10.2.3.33:6800/5236 >>
10.2.3.105:6842/5408 pipe(0x26f5c00 sd=30 :38240 s=1 pgs=0 cs=0 l=1
c=0x280a000).failed verifying authorize reply



On Thu, Feb 26, 2015 at 1:18 PM, John Spray <john.spray@redhat.com> wrote:
>
>
> On 26/02/2015 18:07, Wyllys Ingersoll wrote:
>>
>> Here is 'ceph df', followed by "mds dump" and "osd dump"
>
>
> Your MDS map is trying to use pool 0 for both data and metadata. Firstly,
> these should be different pools.  Secondly, you have no pool 0.  You do have
> metadata and data pools with ids 6 and 7, so you should be typing "ceph mds
> newfs 6 7".
>
> Note that this situation can't occur on more recent versions of Ceph, where
> the filesystem<->pool relations are enforced strictly.  If you are intent on
> using the filesystem, you should consider using more recent versions to
> benefit from the numerous other filesystem bugfixes.
>
> Cheers,
> John
>
>> $ ceph df
>> GLOBAL:
>>      SIZE      AVAIL     RAW USED     %RAW USED
>>      1307T     1302T        5039G          0.38
>> POOLS:
>>      NAME          ID     USED      %USED     MAX AVAIL     OBJECTS
>>      ks3backup     3       160M         0             0           9
>>      test          4          0         0             0           0
>>      TEST          5      2501G      0.19             0      320263
>>      metadata      6          0         0             0           0
>>      data          7          0         0             0           0
>>      rbd           8          0         0             0           0
>>
>> $ ceph mds dump
>> dumped mdsmap epoch 220
>> epoch 220
>> flags 0
>> created 2015-02-26 07:43:23.410584
>> modified 2015-02-26 07:55:28.817383
>> tableserver 0
>> root 0
>> session_timeout 60
>> session_autoclose 300
>> max_file_size 1099511627776
>> last_failure 0
>> last_failure_osd_epoch 867
>> compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable
>> ranges,3=default file layouts on dirs,4=dir inode in separate
>> object,5=mds uses versioned encoding,6=dirfrag is stored in omap}
>> max_mds 1
>> in 0
>> up {0=20039}
>> failed
>> stopped
>> data_pools 0
>> metadata_pool 0
>> inline_data disabled
>> 20039: 10.2.3.33:6800/5098 'mdc03' mds.0.91 up:creating seq 1 laggy
>> since 2015-02-26 07:55:28.817341
>>
>> $ ceph osd dump
>> epoch 872
>> fsid e73bfab8-01f1-4534-9a66-1b425d5c3341
>> created 2015-02-23 07:53:05.626725
>> modified 2015-02-26 08:01:48.834331
>> flags
>> pool 3 'ks3backup' replicated size 2 min_size 1 crush_ruleset 0
>> object_hash rjenkins pg_num 512 pgp_num 512 last_change 251 flags
>> hashpspool stripe_width 0
>> pool 4 'test' replicated size 2 min_size 1 crush_ruleset 0 object_hash
>> rjenkins pg_num 512 pgp_num 512 last_change 363 flags hashpspool
>> stripe_width 0
>> pool 5 'TEST' replicated size 2 min_size 1 crush_ruleset 0 object_hash
>> rjenkins pg_num 1024 pgp_num 1024 last_change 473 flags hashpspool
>> stripe_width 0
>> pool 6 'metadata' replicated size 2 min_size 1 crush_ruleset 0
>> object_hash rjenkins pg_num 1024 pgp_num 1024 last_change 808 flags
>> hashpspool stripe_width 0
>> pool 7 'data' replicated size 2 min_size 1 crush_ruleset 0 object_hash
>> rjenkins pg_num 1024 pgp_num 1024 last_change 810 flags hashpspool
>> stripe_width 0
>> pool 8 'rbd' replicated size 2 min_size 1 crush_ruleset 0 object_hash
>> rjenkins pg_num 512 pgp_num 512 last_change 833 flags hashpspool
>> stripe_width 0
>> max_osd 242
>> osd.0 up   in  weight 1 up_from 774 up_thru 833 down_at 748
>> last_clean_interval [692,747) 10.2.2.109:6851/6280
>> 10.3.2.109:6834/6280 10.3.2.109:6835/6280 10.2.2.109:6852/6280
>> exists,up 43999652-2966-4b1b-a8f0-c33ef5db0970
>> osd.1 up   in  weight 1 up_from 648 up_thru 833 down_at 630
>> last_clean_interval [598,629) 10.2.3.105:6857/6775
>> 10.3.3.105:6838/6775 10.3.3.105:6839/6775 10.2.3.105:6858/6775
>> exists,up 1e4b6fa3-044c-40b8-9f5b-968bdfae5dd7
>> osd.2 up   in  weight 1 up_from 627 up_thru 833 down_at 619
>> last_clean_interval [455,618) 10.2.1.108:6848/5782
>> 10.3.1.108:6832/5782 10.3.1.108:6833/5782 10.2.1.108:6849/5782
>> exists,up 95000872-72f2-46e8-8d4a-f9b1422032cb
>> osd.3 up   in  weight 1 up_from 773 up_thru 833 down_at 752
>> last_clean_interval [693,751) 10.2.2.110:6833/4189
>> 10.3.2.110:6822/4189 10.3.2.110:6823/4189 10.2.2.110:6834/4189
>> exists,up 980182ab-51bf-4cd9-a9a4-cfca05123592
>> osd.4 up   in  weight 1 up_from 732 up_thru 833 down_at 722
>> last_clean_interval [718,721) 10.2.1.101:6806/2789
>> 10.3.1.101:6804/2789 10.3.1.101:6805/2789 10.2.1.101:6807/2789
>> exists,up 92a8fe48-082d-4ad1-93ba-5a4f9598d866
>> osd.5 up   in  weight 1 up_from 766 up_thru 810 down_at 739
>> last_clean_interval [663,738) 10.2.3.111:6800/4353
>> 10.3.3.111:6800/4353 10.3.3.111:6801/4353 10.2.3.111:6801/4353
>> exists,up d6539347-2c2a-4fba-867d-74c84b2018ad
>> osd.6 up   in  weight 1 up_from 781 up_thru 833 down_at 760
>> last_clean_interval [711,759) 10.2.2.104:6830/4317
>> 10.3.2.104:6820/4317 10.3.2.104:6821/4317 10.2.2.104:6831/4317
>> exists,up 55b05a0f-2b17-44e2-84c5-78db81ea862b
>> osd.7 up   in  weight 1 up_from 639 up_thru 833 down_at 633
>> last_clean_interval [608,632) 10.2.3.106:6842/4762
>> 10.3.3.106:6828/4762 10.3.3.106:6829/4762 10.2.3.106:6843/4762
>> exists,up 6a62d4fc-487c-4b39-a64a-823d675969a9
>> osd.8 up   in  weight 1 up_from 769 up_thru 833 down_at 744
>> last_clean_interval [671,743) 10.2.3.112:6845/5168
>> 10.3.3.112:6830/5168 10.3.3.112:6831/5168 10.2.3.112:6846/5168
>> exists,up 9c4202e6-7749-4436-adb1-9c8bf1dc7f04
>> osd.9 up   in  weight 1 up_from 734 up_thru 833 down_at 727
>> last_clean_interval [719,726) 10.2.1.102:6809/3004
>> 10.3.1.102:6806/3004 10.3.1.102:6807/3004 10.2.1.102:6810/3004
>> exists,up 2d0a4808-99d7-4a6e-b8d9-15793797830a
>> osd.10 up   in  weight 1 up_from 780 up_thru 810 down_at 756
>> last_clean_interval [711,755) 10.2.2.103:6836/4424
>> 10.3.2.103:6824/4424 10.3.2.103:6825/4424 10.2.2.103:6837/4424
>> exists,up 69efa89e-3a3d-4be4-a737-28ef4ad369c0
>> osd.11 up   in  weight 1 up_from 625 up_thru 833 down_at 615
>> last_clean_interval [466,614) 10.2.1.107:6839/4742
>> 10.3.1.107:6826/4742 10.3.1.107:6827/4742 10.2.1.107:6840/4742
>> exists,up 17d5c13c-bfa1-4291-957e-967d43f2e15b
>> osd.12 up   in  weight 1 up_from 773 up_thru 833 down_at 748
>> last_clean_interval [692,747) 10.2.2.109:6833/4409
>> 10.3.2.109:6822/4409 10.3.2.109:6823/4409 10.2.2.109:6834/4409
>> exists,up 14b42b0f-c20a-4083-b5c5-5960cd221244
>> osd.13 up   in  weight 1 up_from 639 up_thru 833 down_at 633
>> last_clean_interval [607,632) 10.2.3.106:6839/4618
>> 10.3.3.106:6826/4618 10.3.3.106:6827/4618 10.2.3.106:6840/4618
>> exists,up 46240cb7-f6f3-4579-9bc0-6ddb64275172
>> osd.14 up   in  weight 1 up_from 735 up_thru 833 down_at 727
>> last_clean_interval [720,726) 10.2.1.102:6827/3978
>> 10.3.1.102:6818/3978 10.3.1.102:6819/3978 10.2.1.102:6828/3978
>> exists,up e4883def-77b1-4605-bded-ebed75636241
>> osd.15 up   in  weight 1 up_from 775 up_thru 833 down_at 752
>> last_clean_interval [694,751) 10.2.2.110:6851/6591
>> 10.3.2.110:6834/6591 10.3.2.110:6835/6591 10.2.2.110:6852/6591
>> exists,up bf04a229-e851-4907-a9b0-d26b844db037
>> osd.16 up   in  weight 1 up_from 766 up_thru 833 down_at 739
>> last_clean_interval [662,738) 10.2.3.111:6810/4368
>> 10.3.3.111:6808/4368 10.3.3.111:6812/4368 10.2.3.111:6814/4368
>> exists,up 551340b1-98d9-4a67-b1d6-aa12d0967196
>> osd.17 up   in  weight 1 up_from 736 up_thru 833 down_at 722
>> last_clean_interval [719,721) 10.2.1.101:6851/6534
>> 10.3.1.101:6834/6534 10.3.1.101:6835/6534 10.2.1.101:6852/6534
>> exists,up a53b2900-30be-4f65-a0c0-3400070706f3
>> osd.18 up   in  weight 1 up_from 645 up_thru 833 down_at 630
>> last_clean_interval [602,629) 10.2.3.105:6824/3776
>> 10.3.3.105:6816/3776 10.3.3.105:6817/3776 10.2.3.105:6825/3776
>> exists,up 38a1f673-c195-4266-a623-2b069e2cebf9
>> osd.19 up   in  weight 1 up_from 626 up_thru 833 down_at 619
>> last_clean_interval [454,618) 10.2.1.108:6836/4575
>> 10.3.1.108:6824/4575 10.3.1.108:6825/4575 10.2.1.108:6837/4575
>> exists,up c5f53b42-b05e-4c30-9e96-b5cec2b7fe59
>> osd.20 up   in  weight 1 up_from 765 up_thru 810 down_at 744
>> last_clean_interval [667,742) 10.2.3.112:6802/3795
>> 10.3.3.112:6802/3795 10.3.3.112:6805/3795 10.2.3.112:6807/3795
>> exists,up 081625e4-ca5f-41af-b524-0aff23e2f162
>> osd.21 up   in  weight 1 up_from 782 up_thru 833 down_at 760
>> last_clean_interval [710,759) 10.2.2.104:6848/6085
>> 10.3.2.104:6832/6085 10.3.2.104:6833/6085 10.2.2.104:6849/6085
>> exists,up d99a53ce-98ad-4d6a-9124-454434d24e12
>> osd.22 up   in  weight 1 up_from 626 up_thru 833 down_at 615
>> last_clean_interval [466,614) 10.2.1.107:6842/4920
>> 10.3.1.107:6828/4920 10.3.1.107:6829/4920 10.2.1.107:6843/4920
>> exists,up ab5c5015-c32e-4119-b991-47a497c1fabd
>> osd.23 up   in  weight 1 up_from 779 up_thru 810 down_at 756
>> last_clean_interval [708,755) 10.2.2.103:6818/3084
>> 10.3.2.103:6812/3084 10.3.2.103:6813/3084 10.2.2.103:6819/3084
>> exists,up 36a2ab86-3124-40ca-8ec5-b3a75cd06482
>> osd.24 up   in  weight 1 up_from 773 up_thru 833 down_at 748
>> last_clean_interval [693,747) 10.2.2.109:6836/4538
>> 10.3.2.109:6824/4538 10.3.2.109:6825/4538 10.2.2.109:6837/4538
>> exists,up b4cf2203-b031-4f65-9155-736fd2d78e97
>> osd.25 up   in  weight 1 up_from 773 up_thru 833 down_at 752
>> last_clean_interval [694,751) 10.2.2.110:6824/3284
>> 10.3.2.110:6816/3284 10.3.2.110:6817/3284 10.2.2.110:6825/3284
>> exists,up 102d241e-825f-4dd9-af72-058fed3fbb0f
>> osd.26 up   in  weight 1 up_from 640 up_thru 833 down_at 633
>> last_clean_interval [607,632) 10.2.3.106:6848/5787
>> 10.3.3.106:6832/5787 10.3.3.106:6833/5787 10.2.3.106:6849/5787
>> exists,up c934348b-92d4-4ae2-a40e-795cdd68a947
>> osd.27 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [661,738) 10.2.3.111:6821/4386
>> 10.3.3.111:6814/4386 10.3.3.111:6815/4386 10.2.3.111:6822/4386
>> exists,up 6354d07f-3f96-4157-8e5b-bccc69bc2273
>> osd.28 up   in  weight 1 up_from 736 up_thru 833 down_at 727
>> last_clean_interval [717,726) 10.2.1.102:6851/6511
>> 10.3.1.102:6834/6511 10.3.1.102:6835/6511 10.2.1.102:6852/6511
>> exists,up a67195b0-b8cc-4f68-bc95-5d7731188c81
>> osd.29 up   in  weight 1 up_from 628 up_thru 833 down_at 619
>> last_clean_interval [452,618) 10.2.1.108:6857/6875
>> 10.3.1.108:6838/6875 10.3.1.108:6839/6875 10.2.1.108:6858/6875
>> exists,up a887abe7-e9b2-41f3-8a47-9046a0ca6404
>> osd.30 up   in  weight 1 up_from 781 up_thru 833 down_at 760
>> last_clean_interval [712,759) 10.2.2.104:6833/4445
>> 10.3.2.104:6822/4445 10.3.2.104:6823/4445 10.2.2.104:6834/4445
>> exists,up c1c49afb-164c-4b46-9d40-2b3c37811439
>> osd.31 up   in  weight 1 up_from 768 up_thru 833 down_at 744
>> last_clean_interval [669,743) 10.2.3.112:6848/7064
>> 10.3.3.112:6832/7064 10.3.3.112:6833/7064 10.2.3.112:6849/7064
>> exists,up 26121990-1276-4757-b46a-cdb1999f083d
>> osd.32 up   in  weight 1 up_from 735 up_thru 833 down_at 722
>> last_clean_interval [718,721) 10.2.1.101:6839/5315
>> 10.3.1.101:6826/5315 10.3.1.101:6827/5315 10.2.1.101:6840/5315
>> exists,up 9cbc8844-730c-4250-a08d-1eaecc88da99
>> osd.33 up   in  weight 1 up_from 648 up_thru 833 down_at 630
>> last_clean_interval [597,629) 10.2.3.105:6854/6295
>> 10.3.3.105:6836/6295 10.3.3.105:6837/6295 10.2.3.105:6855/6295
>> exists,up 42c72969-8d12-4873-ba31-eaac6df2f099
>> osd.34 up   in  weight 1 up_from 625 up_thru 833 down_at 615
>> last_clean_interval [465,614) 10.2.1.107:6830/4031
>> 10.3.1.107:6820/4031 10.3.1.107:6821/4031 10.2.1.107:6831/4031
>> exists,up 93bb297c-03d3-44cf-ac29-0bf9f6a7056f
>> osd.35 up   in  weight 1 up_from 780 up_thru 833 down_at 756
>> last_clean_interval [711,755) 10.2.2.103:6839/4550
>> 10.3.2.103:6826/4550 10.3.2.103:6827/4550 10.2.2.103:6840/4550
>> exists,up ff0163b7-5eec-4d27-8838-d5b574bbbce1
>> osd.36 up   in  weight 1 up_from 773 up_thru 833 down_at 748
>> last_clean_interval [694,747) 10.2.2.109:6839/4693
>> 10.3.2.109:6826/4693 10.3.2.109:6827/4693 10.2.2.109:6840/4693
>> exists,up 69f50a5f-de37-40a2-b4eb-6aa655f2f18f
>> osd.37 up   in  weight 1 up_from 776 up_thru 833 down_at 752
>> last_clean_interval [692,751) 10.2.2.110:6854/7101
>> 10.3.2.110:6836/7101 10.3.2.110:6837/7101 10.2.2.110:6855/7101
>> exists,up e6810117-8904-49a5-b671-c0b1de7ac80e
>> osd.38 up   in  weight 1 up_from 640 up_thru 833 down_at 633
>> last_clean_interval [606,632) 10.2.3.106:6851/6088
>> 10.3.3.106:6834/6088 10.3.3.106:6835/6088 10.2.3.106:6852/6088
>> exists,up 2414575f-455d-42f7-b4d6-0ec47ac09972
>> osd.39 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [661,738) 10.2.3.111:6845/4477
>> 10.3.3.111:6830/4477 10.3.3.111:6831/4477 10.2.3.111:6846/4477
>> exists,up 48ea62f9-862d-496a-bee9-cc461e2110ee
>> osd.40 up   in  weight 1 up_from 736 up_thru 833 down_at 727
>> last_clean_interval [717,726) 10.2.1.102:6848/6063
>> 10.3.1.102:6832/6063 10.3.1.102:6833/6063 10.2.1.102:6849/6063
>> exists,up 726479fc-b165-4244-a3fb-4edf37153299
>> osd.41 up   in  weight 1 up_from 626 up_thru 833 down_at 619
>> last_clean_interval [452,618) 10.2.1.108:6824/3643
>> 10.3.1.108:6816/3643 10.3.1.108:6817/3643 10.2.1.108:6825/3643
>> exists,up 615d72c4-96b1-4969-be46-fbbd59e0a560
>> osd.42 up   in  weight 1 up_from 781 up_thru 810 down_at 760
>> last_clean_interval [713,759) 10.2.2.104:6827/3944
>> 10.3.2.104:6818/3944 10.3.2.104:6819/3944 10.2.2.104:6828/3944
>> exists,up b5e0904b-5167-4ede-b50e-43576c3e57a8
>> osd.43 up   in  weight 1 up_from 647 up_thru 833 down_at 630
>> last_clean_interval [595,629) 10.2.3.105:6845/5527
>> 10.3.3.105:6830/5527 10.3.3.105:6831/5527 10.2.3.105:6846/5527
>> exists,up 9a81e3f3-a3cb-4933-829c-dff1fa50e663
>> osd.44 up   in  weight 1 up_from 769 up_thru 833 down_at 744
>> last_clean_interval [671,743) 10.2.3.112:6800/3801
>> 10.3.3.112:6801/3801 10.3.3.112:6804/3801 10.2.3.112:6805/3801
>> exists,up 6f747700-67d7-4f39-b7bc-7a090f56914d
>> osd.45 up   in  weight 1 up_from 734 up_thru 833 down_at 722
>> last_clean_interval [718,721) 10.2.1.101:6824/3800
>> 10.3.1.101:6816/3800 10.3.1.101:6817/3800 10.2.1.101:6825/3800
>> exists,up 9b1839da-7771-484b-849d-6f34cd0f71f3
>> osd.46 up   in  weight 1 up_from 780 up_thru 833 down_at 756
>> last_clean_interval [710,755) 10.2.2.103:6830/4069
>> 10.3.2.103:6820/4069 10.3.2.103:6821/4069 10.2.2.103:6831/4069
>> exists,up b1cc292c-b56a-4949-a9cd-345d7591b4be
>> osd.47 up   in  weight 1 up_from 624 up_thru 833 down_at 615
>> last_clean_interval [466,614) 10.2.1.107:6824/3426
>> 10.3.1.107:6816/3426 10.3.1.107:6817/3426 10.2.1.107:6825/3426
>> exists,up 646b30a3-3ce1-4f69-a915-b2674db5d4a2
>> osd.48 up   in  weight 1 up_from 772 up_thru 810 down_at 748
>> last_clean_interval [693,747) 10.2.2.109:6818/3143
>> 10.3.2.109:6812/3143 10.3.2.109:6813/3143 10.2.2.109:6819/3143
>> exists,up c763ff49-047e-46b2-b95b-0ce66c9abac4
>> osd.49 up   in  weight 1 up_from 773 up_thru 810 down_at 752
>> last_clean_interval [694,751) 10.2.2.110:6827/3710
>> 10.3.2.110:6818/3710 10.3.2.110:6819/3710 10.2.2.110:6828/3710
>> exists,up 4101b6d3-d149-4c22-8175-e8dfe6e432b2
>> osd.50 up   in  weight 1 up_from 639 up_thru 810 down_at 633
>> last_clean_interval [606,632) 10.2.3.106:6830/3753
>> 10.3.3.106:6820/3753 10.3.3.106:6821/3753 10.2.3.106:6831/3753
>> exists,up 978fcb37-e08e-486d-96c7-32cf476da927
>> osd.51 up   in  weight 1 up_from 766 up_thru 833 down_at 739
>> last_clean_interval [662,738) 10.2.3.111:6812/4383
>> 10.3.3.111:6809/4383 10.3.3.111:6813/4383 10.2.3.111:6816/4383
>> exists,up b9061b7c-d712-4739-8528-4acf8a529d13
>> osd.52 up   in  weight 1 up_from 647 up_thru 833 down_at 630
>> last_clean_interval [598,629) 10.2.3.105:6842/5408
>> 10.3.3.105:6828/5408 10.3.3.105:6829/5408 10.2.3.105:6843/5408
>> exists,up d1ac7f8d-450a-4f86-948a-ea9c21b44e6f
>> osd.53 up   in  weight 1 up_from 627 up_thru 833 down_at 619
>> last_clean_interval [452,618) 10.2.1.108:6845/5640
>> 10.3.1.108:6830/5640 10.3.1.108:6831/5640 10.2.1.108:6846/5640
>> exists,up 2b818e93-1ad6-420f-864b-2a81355390fc
>> osd.54 up   in  weight 1 up_from 779 up_thru 833 down_at 760
>> last_clean_interval [710,759) 10.2.2.104:6806/2964
>> 10.3.2.104:6804/2964 10.3.2.104:6805/2964 10.2.2.104:6807/2964
>> exists,up b158bdd0-73e8-4923-96c6-1f5cf63c95d6
>> osd.55 up   in  weight 1 up_from 736 up_thru 833 down_at 727
>> last_clean_interval [720,726) 10.2.1.102:6845/5724
>> 10.3.1.102:6830/5724 10.3.1.102:6831/5724 10.2.1.102:6846/5724
>> exists,up 7484647f-cb80-4d65-9eb1-9aa559f0f978
>> osd.56 up   in  weight 1 up_from 734 up_thru 833 down_at 722
>> last_clean_interval [717,721) 10.2.1.101:6836/5114
>> 10.3.1.101:6824/5114 10.3.1.101:6825/5114 10.2.1.101:6837/5114
>> exists,up 27246b24-7149-481a-b195-73e208265a08
>> osd.57 up   in  weight 1 up_from 769 up_thru 833 down_at 744
>> last_clean_interval [671,743) 10.2.3.112:6857/7560
>> 10.3.3.112:6838/7560 10.3.3.112:6839/7560 10.2.3.112:6858/7560
>> exists,up dd22f8d2-03df-41b5-b039-cf3bf41e22e7
>> osd.58 up   in  weight 1 up_from 779 up_thru 833 down_at 756
>> last_clean_interval [711,755) 10.2.2.103:6815/2992
>> 10.3.2.103:6810/2992 10.3.2.103:6811/2992 10.2.2.103:6816/2992
>> exists,up 619e2e5b-8c74-4170-a898-67a5aeaebcb6
>> osd.59 up   in  weight 1 up_from 623 up_thru 810 down_at 615
>> last_clean_interval [467,614) 10.2.1.107:6809/2975
>> 10.3.1.107:6806/2975 10.3.1.107:6807/2975 10.2.1.107:6810/2975
>> exists,up 02e15cc1-7380-4235-981e-cd83e909f66d
>> osd.60 up   in  weight 1 up_from 772 up_thru 833 down_at 748
>> last_clean_interval [691,747) 10.2.2.109:6827/3851
>> 10.3.2.109:6818/3851 10.3.2.109:6819/3851 10.2.2.109:6828/3851
>> exists,up c8c17a47-013e-4957-aab8-dc98dad878cd
>> osd.61 up   in  weight 1 up_from 638 up_thru 833 down_at 633
>> last_clean_interval [608,632) 10.2.3.106:6824/3275
>> 10.3.3.106:6816/3275 10.3.3.106:6817/3275 10.2.3.106:6825/3275
>> exists,up 8def34c7-a5b8-4d04-b724-ae8627830fe3
>> osd.62 up   in  weight 1 up_from 777 up_thru 833 down_at 752
>> last_clean_interval [693,751) 10.2.2.110:6857/8125
>> 10.3.2.110:6838/8125 10.3.2.110:6839/8125 10.2.2.110:6858/8125
>> exists,up 42259595-c820-407e-9a6e-654702dbc89b
>> osd.63 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [662,738) 10.2.3.111:6809/4371
>> 10.3.3.111:6806/4371 10.3.3.111:6810/4371 10.2.3.111:6813/4371
>> exists,up b177106c-c4e2-4d01-bc9f-3df0494e5edb
>> osd.64 up   in  weight 1 up_from 645 up_thru 833 down_at 630
>> last_clean_interval [597,629) 10.2.3.105:6818/3419
>> 10.3.3.105:6812/3419 10.3.3.105:6813/3419 10.2.3.105:6819/3419
>> exists,up 7edc4897-a98d-4810-be69-710a6b46350b
>> osd.65 up   in  weight 1 up_from 628 up_thru 833 down_at 619
>> last_clean_interval [455,618) 10.2.1.108:6854/6690
>> 10.3.1.108:6836/6690 10.3.1.108:6837/6690 10.2.1.108:6855/6690
>> exists,up 11ac2519-2dd3-4674-96c4-90de484fbe73
>> osd.66 up   in  weight 1 up_from 734 up_thru 833 down_at 727
>> last_clean_interval [718,726) 10.2.1.102:6821/3318
>> 10.3.1.102:6814/3318 10.3.1.102:6815/3318 10.2.1.102:6822/3318
>> exists,up 1be2f979-0a99-4e66-8899-4e7b496e1002
>> osd.67 up   in  weight 1 up_from 781 up_thru 833 down_at 760
>> last_clean_interval [712,759) 10.2.2.104:6839/4806
>> 10.3.2.104:6826/4806 10.3.2.104:6827/4806 10.2.2.104:6840/4806
>> exists,up 7b6301c7-ec16-4d1f-a163-21c656984245
>> osd.68 up   in  weight 1 up_from 733 up_thru 833 down_at 722
>> last_clean_interval [719,721) 10.2.1.101:6812/3044
>> 10.3.1.101:6808/3044 10.3.1.101:6809/3044 10.2.1.101:6813/3044
>> exists,up 87cd5099-c6ef-4a9a-814a-0e5a8a724e22
>> osd.69 up   in  weight 1 up_from 766 up_thru 833 down_at 744
>> last_clean_interval [669,743) 10.2.3.112:6803/3803
>> 10.3.3.112:6806/3803 10.3.3.112:6807/3803 10.2.3.112:6810/3803
>> exists,up 165d0685-58db-4bfc-a169-db88e0f2c213
>> osd.70 up   in  weight 1 up_from 781 up_thru 810 down_at 756
>> last_clean_interval [711,755) 10.2.2.103:6848/5951
>> 10.3.2.103:6832/5951 10.3.2.103:6833/5951 10.2.2.103:6849/5951
>> exists,up a4117bd8-5b70-48ed-a784-8ef7d0c6edf3
>> osd.71 up   in  weight 1 up_from 626 up_thru 833 down_at 615
>> last_clean_interval [465,614) 10.2.1.107:6851/6097
>> 10.3.1.107:6834/6097 10.3.1.107:6835/6097 10.2.1.107:6852/6097
>> exists,up 4a74899c-32a0-42d0-a963-28311954391f
>> osd.72 up   in  weight 1 up_from 772 up_thru 833 down_at 748
>> last_clean_interval [691,747) 10.2.2.109:6812/3118
>> 10.3.2.109:6808/3118 10.3.2.109:6809/3118 10.2.2.109:6813/3118
>> exists,up 52b0ac5e-aa5c-4821-a4ac-27f2cbdf1e95
>> osd.73 up   in  weight 1 up_from 639 up_thru 833 down_at 633
>> last_clean_interval [606,632) 10.2.3.106:6833/4204
>> 10.3.3.106:6822/4204 10.3.3.106:6823/4204 10.2.3.106:6834/4204
>> exists,up 65bf6fc9-83dd-4330-b10a-313395e51492
>> osd.74 up   in  weight 1 up_from 775 up_thru 833 down_at 752
>> last_clean_interval [692,751) 10.2.2.110:6848/6317
>> 10.3.2.110:6832/6317 10.3.2.110:6833/6317 10.2.2.110:6849/6317
>> exists,up af32455f-b8c1-474a-9f3c-ee2453a14232
>> osd.75 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [663,738) 10.2.3.111:6848/4652
>> 10.3.3.111:6832/4652 10.3.3.111:6833/4652 10.2.3.111:6849/4652
>> exists,up 0ce63ecf-80fc-404d-a9a2-4b1549f5f193
>> osd.76 up   in  weight 1 up_from 644 up_thru 833 down_at 630
>> last_clean_interval [594,629) 10.2.3.105:6803/2693
>> 10.3.3.105:6802/2693 10.3.3.105:6803/2693 10.2.3.105:6804/2693
>> exists,up 410d5647-ae84-46a8-8048-4832964a2615
>> osd.77 up   in  weight 1 up_from 734 up_thru 833 down_at 727
>> last_clean_interval [719,726) 10.2.1.102:6816/3134
>> 10.3.1.102:6811/3134 10.3.1.102:6813/3134 10.2.1.102:6818/3134
>> exists,up 30723422-ce2a-4354-8549-1465dcc1a05a
>> osd.78 up   in  weight 1 up_from 628 up_thru 833 down_at 619
>> last_clean_interval [458,618) 10.2.1.108:6851/6040
>> 10.3.1.108:6834/6040 10.3.1.108:6835/6040 10.2.1.108:6852/6040
>> exists,up 7b759d33-6511-4f66-af03-3d891aeb1083
>> osd.79 up   in  weight 1 up_from 781 up_thru 833 down_at 760
>> last_clean_interval [710,759) 10.2.2.104:6836/4620
>> 10.3.2.104:6824/4620 10.3.2.104:6825/4620 10.2.2.104:6837/4620
>> exists,up ea12e5e8-d880-4f88-96d5-cfae6bc3f890
>> osd.80 up   in  weight 1 up_from 733 up_thru 810 down_at 722
>> last_clean_interval [716,721) 10.2.1.101:6818/3297
>> 10.3.1.101:6812/3297 10.3.1.101:6813/3297 10.2.1.101:6819/3297
>> exists,up 61d7defb-d48d-40dd-b4cf-925caebc83e3
>> osd.81 up   in  weight 1 up_from 769 up_thru 833 down_at 744
>> last_clean_interval [667,742) 10.2.3.112:6801/3807
>> 10.3.3.112:6800/3807 10.3.3.112:6803/3807 10.2.3.112:6804/3807
>> exists,up 040162fc-3b7e-48bb-8754-0817ec2449a1
>> osd.82 up   in  weight 1 up_from 624 up_thru 833 down_at 615
>> last_clean_interval [465,614) 10.2.1.107:6815/3078
>> 10.3.1.107:6810/3078 10.3.1.107:6811/3078 10.2.1.107:6816/3078
>> exists,up 14601e93-8f09-48da-abb6-eeccf2d1c043
>> osd.83 up   in  weight 1 up_from 779 up_thru 833 down_at 756
>> last_clean_interval [711,755) 10.2.2.103:6821/3260
>> 10.3.2.103:6814/3260 10.3.2.103:6815/3260 10.2.2.103:6822/3260
>> exists,up 45158a13-f8be-4a8e-963d-9b617b5d4507
>> osd.84 up   in  weight 1 up_from 772 up_thru 810 down_at 748
>> last_clean_interval [696,747) 10.2.2.109:6803/3001
>> 10.3.2.109:6802/3001 10.3.2.109:6803/3001 10.2.2.109:6804/3001
>> exists,up fc50b1c6-cc19-4b81-8bc8-8e3d007f0ce4
>> osd.85 up   in  weight 1 up_from 641 up_thru 833 down_at 633
>> last_clean_interval [608,632) 10.2.3.106:6854/6342
>> 10.3.3.106:6836/6342 10.3.3.106:6837/6342 10.2.3.106:6855/6342
>> exists,up 6494c679-0ad6-45cf-b179-38f554da46f3
>> osd.86 up   in  weight 1 up_from 774 up_thru 833 down_at 752
>> last_clean_interval [695,751) 10.2.2.110:6836/5200
>> 10.3.2.110:6824/5200 10.3.2.110:6825/5200 10.2.2.110:6837/5200
>> exists,up 152c4c3f-38ae-4f87-bf55-d23be5bc01f5
>> osd.87 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [660,738) 10.2.3.111:6827/4413
>> 10.3.3.111:6818/4413 10.3.3.111:6819/4413 10.2.3.111:6828/4413
>> exists,up 35401474-b0e3-47d2-9a46-e7a565d11543
>> osd.88 up   in  weight 1 up_from 625 up_thru 833 down_at 619
>> last_clean_interval [450,618) 10.2.1.108:6812/3006
>> 10.3.1.108:6808/3006 10.3.1.108:6809/3006 10.2.1.108:6813/3006
>> exists,up 2cf7e048-b515-4093-8733-af82159bd0c8
>> osd.89 up   in  weight 1 up_from 648 up_thru 833 down_at 630
>> last_clean_interval [595,629) 10.2.3.105:6851/6100
>> 10.3.3.105:6834/6100 10.3.3.105:6835/6100 10.2.3.105:6852/6100
>> exists,up 7a487064-7255-4c30-8cf0-a0c731d00bea
>> osd.90 up   in  weight 1 up_from 734 up_thru 833 down_at 727
>> last_clean_interval [719,726) 10.2.1.102:6812/3112
>> 10.3.1.102:6808/3112 10.3.1.102:6809/3112 10.2.1.102:6813/3112
>> exists,up 9be24215-0832-4384-b28b-c49d39c58d5b
>> osd.91 up   in  weight 1 up_from 782 up_thru 833 down_at 760
>> last_clean_interval [713,759) 10.2.2.104:6845/5900
>> 10.3.2.104:6830/5900 10.3.2.104:6831/5900 10.2.2.104:6846/5900
>> exists,up 203b80c5-2c4f-4250-a3f7-1c9b1954730e
>> osd.92 up   in  weight 1 up_from 735 up_thru 833 down_at 722
>> last_clean_interval [716,721) 10.2.1.101:6848/6336
>> 10.3.1.101:6832/6336 10.3.1.101:6833/6336 10.2.1.101:6849/6336
>> exists,up 109f9a06-039a-4aee-9347-52ba3bda74a3
>> osd.93 up   in  weight 1 up_from 627 up_thru 833 down_at 615
>> last_clean_interval [468,614) 10.2.1.107:6854/6395
>> 10.3.1.107:6836/6395 10.3.1.107:6837/6395 10.2.1.107:6855/6395
>> exists,up 9c9507c6-4ea5-4f4f-a675-6145ff5f9d30
>> osd.94 up   in  weight 1 up_from 769 up_thru 833 down_at 744
>> last_clean_interval [668,743) 10.2.3.112:6851/7385
>> 10.3.3.112:6834/7385 10.3.3.112:6835/7385 10.2.3.112:6852/7385
>> exists,up fdc854b9-9026-46de-8019-d7dc95380d65
>> osd.95 up   in  weight 1 up_from 780 up_thru 833 down_at 756
>> last_clean_interval [710,755) 10.2.2.103:6827/3819
>> 10.3.2.103:6818/3819 10.3.2.103:6819/3819 10.2.2.103:6828/3819
>> exists,up 206b41d8-a15f-4633-961b-fac54e019dff
>> osd.96 up   in  weight 1 up_from 772 up_thru 833 down_at 748
>> last_clean_interval [692,747) 10.2.2.109:6815/3126
>> 10.3.2.109:6810/3126 10.3.2.109:6811/3126 10.2.2.109:6816/3126
>> exists,up f2a67be3-01ac-4bdb-adc0-f2c80c077c0d
>> osd.97 up   in  weight 1 up_from 638 up_thru 833 down_at 633
>> last_clean_interval [608,632) 10.2.3.106:6809/2996
>> 10.3.3.106:6806/2996 10.3.3.106:6807/2996 10.2.3.106:6810/2996
>> exists,up 500731d3-5d08-4031-9c10-3b0f79bc32aa
>> osd.98 up   in  weight 1 up_from 775 up_thru 833 down_at 752
>> last_clean_interval [693,751) 10.2.2.110:6842/5795
>> 10.3.2.110:6828/5795 10.3.2.110:6829/5795 10.2.2.110:6843/5795
>> exists,up ac16d05d-3684-4ab3-9bea-531d97ee0d94
>> osd.99 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [661,738) 10.2.3.111:6803/4360
>> 10.3.3.111:6802/4360 10.3.3.111:6803/4360 10.2.3.111:6804/4360
>> exists,up 1b3e1cce-45d7-4d12-8e58-4a582db5271b
>> osd.100 up   in  weight 1 up_from 624 up_thru 833 down_at 619
>> last_clean_interval [450,618) 10.2.1.108:6800/2724
>> 10.3.1.108:6800/2724 10.3.1.108:6801/2724 10.2.1.108:6801/2724
>> exists,up 035502e6-9467-48e2-994c-6acf251d3d19
>> osd.101 up   in  weight 1 up_from 646 up_thru 833 down_at 630
>> last_clean_interval [594,629) 10.2.3.105:6839/4923
>> 10.3.3.105:6826/4923 10.3.3.105:6827/4923 10.2.3.105:6840/4923
>> exists,up d065f777-7433-4817-9b4b-a95fa1987dc4
>> osd.102 up   in  weight 1 up_from 732 up_thru 833 down_at 722
>> last_clean_interval [719,721) 10.2.1.101:6803/2709
>> 10.3.1.101:6802/2709 10.3.1.101:6803/2709 10.2.1.101:6804/2709
>> exists,up 84aef94d-a485-4b05-93b2-50bce1623f7e
>> osd.103 up   in  weight 1 up_from 783 up_thru 833 down_at 760
>> last_clean_interval [710,759) 10.2.2.104:6854/6916
>> 10.3.2.104:6836/6916 10.3.2.104:6837/6916 10.2.2.104:6855/6916
>> exists,up 75eb078d-bfdb-4e84-b52f-8c48e8d417dd
>> osd.104 up   in  weight 1 up_from 735 up_thru 833 down_at 727
>> last_clean_interval [716,726) 10.2.1.102:6833/4440
>> 10.3.1.102:6822/4440 10.3.1.102:6823/4440 10.2.1.102:6834/4440
>> exists,up 67ec0cd8-64a6-4868-95a4-e0568ba0645e
>> osd.105 up   in  weight 1 up_from 625 up_thru 833 down_at 615
>> last_clean_interval [464,614) 10.2.1.107:6833/4418
>> 10.3.1.107:6822/4418 10.3.1.107:6823/4418 10.2.1.107:6834/4418
>> exists,up 8c3c329e-bfaf-432d-97e0-a7719d708c0b
>> osd.106 up   in  weight 1 up_from 765 up_thru 833 down_at 744
>> last_clean_interval [667,742) 10.2.3.112:6824/3880
>> 10.3.3.112:6816/3880 10.3.3.112:6817/3880 10.2.3.112:6825/3880
>> exists,up 2c3f5d03-909c-4966-aa6d-8d6a8edfa964
>> osd.107 up   in  weight 1 up_from 779 up_thru 833 down_at 756
>> last_clean_interval [712,755) 10.2.2.103:6806/2960
>> 10.3.2.103:6804/2960 10.3.2.103:6805/2960 10.2.2.103:6807/2960
>> exists,up c2e25d4f-07a2-402b-83eb-2aebd70d6bc7
>> osd.108 up   in  weight 1 up_from 772 up_thru 833 down_at 748
>> last_clean_interval [694,747) 10.2.2.109:6821/3310
>> 10.3.2.109:6814/3310 10.3.2.109:6815/3310 10.2.2.109:6822/3310
>> exists,up 2323f76d-de0a-4c2a-823a-2805675f900e
>> osd.109 up   in  weight 1 up_from 638 up_thru 833 down_at 633
>> last_clean_interval [606,632) 10.2.3.106:6803/2895
>> 10.3.3.106:6802/2895 10.3.3.106:6803/2895 10.2.3.106:6804/2895
>> exists,up 21584a29-bcf7-4461-8867-6e6b337a4126
>> osd.110 up   in  weight 1 up_from 775 up_thru 833 down_at 752
>> last_clean_interval [693,751) 10.2.2.110:6839/5397
>> 10.3.2.110:6826/5397 10.3.2.110:6827/5397 10.2.2.110:6840/5397
>> exists,up c180e193-f37f-43b9-9171-49deeee7d51b
>> osd.111 up   in  weight 1 up_from 766 up_thru 833 down_at 739
>> last_clean_interval [665,738) 10.2.3.111:6811/4378
>> 10.3.3.111:6807/4378 10.3.3.111:6811/4378 10.2.3.111:6815/4378
>> exists,up 6c95ec0c-5383-4edf-a145-963303d1f804
>> osd.112 up   in  weight 1 up_from 645 up_thru 833 down_at 630
>> last_clean_interval [596,629) 10.2.3.105:6821/3552
>> 10.3.3.105:6814/3552 10.3.3.105:6815/3552 10.2.3.105:6822/3552
>> exists,up b3644bf9-71a6-46eb-8850-6349752a8852
>> osd.113 up   in  weight 1 up_from 624 up_thru 833 down_at 619
>> last_clean_interval [454,618) 10.2.1.108:6803/2799
>> 10.3.1.108:6802/2799 10.3.1.108:6803/2799 10.2.1.108:6804/2799
>> exists,up 2b6c0a5c-bf20-46d1-be66-fa01b8f8cf99
>> osd.114 up   in  weight 1 up_from 736 up_thru 833 down_at 722
>> last_clean_interval [717,721) 10.2.1.101:6854/6721
>> 10.3.1.101:6836/6721 10.3.1.101:6837/6721 10.2.1.101:6855/6721
>> exists,up 375c9f34-1305-411d-8d1f-9767c073ad63
>> osd.115 up   in  weight 1 up_from 780 up_thru 833 down_at 760
>> last_clean_interval [710,759) 10.2.2.104:6812/3063
>> 10.3.2.104:6808/3063 10.3.2.104:6809/3063 10.2.2.104:6813/3063
>> exists,up 6beea134-f476-426b-bf31-c27d96b50e1a
>> osd.116 up   in  weight 1 up_from 766 up_thru 810 down_at 744
>> last_clean_interval [668,743) 10.2.3.112:6821/3879
>> 10.3.3.112:6814/3879 10.3.3.112:6815/3879 10.2.3.112:6822/3879
>> exists,up 7880b830-5fe9-44d6-93f3-6884ab5e8e4f
>> osd.117 up   in  weight 1 up_from 735 up_thru 833 down_at 727
>> last_clean_interval [718,726) 10.2.1.102:6836/5134
>> 10.3.1.102:6824/5134 10.3.1.102:6825/5134 10.2.1.102:6837/5134
>> exists,up b25b5589-18c6-4a3b-b09f-d69f7be89961
>> osd.118 up   in  weight 1 up_from 624 up_thru 833 down_at 615
>> last_clean_interval [471,614) 10.2.1.107:6818/3100
>> 10.3.1.107:6812/3100 10.3.1.107:6813/3100 10.2.1.107:6819/3100
>> exists,up 802b2977-5a7e-4c36-a64e-0a28a5d91205
>> osd.119 up   in  weight 1 up_from 779 up_thru 810 down_at 756
>> last_clean_interval [709,755) 10.2.2.103:6803/2959
>> 10.3.2.103:6802/2959 10.3.2.103:6803/2959 10.2.2.103:6804/2959
>> exists,up 13deeea5-dc85-41fe-89ea-4081bbadba2f
>> osd.120 up   in  weight 1 up_from 772 up_thru 833 down_at 748
>> last_clean_interval [694,747) 10.2.2.109:6806/3015
>> 10.3.2.109:6804/3015 10.3.2.109:6805/3015 10.2.2.109:6807/3015
>> exists,up 83ce2668-e885-4c03-a64c-0aca75a182b5
>> osd.121 up   in  weight 1 up_from 638 up_thru 833 down_at 633
>> last_clean_interval [606,632) 10.2.3.106:6821/3102
>> 10.3.3.106:6814/3102 10.3.3.106:6815/3102 10.2.3.106:6822/3102
>> exists,up 98a23c77-56b1-4ce1-8d54-870ef61845ae
>> osd.122 up   in  weight 1 up_from 766 up_thru 833 down_at 739
>> last_clean_interval [660,738) 10.2.3.111:6806/4367
>> 10.3.3.111:6804/4367 10.3.3.111:6805/4367 10.2.3.111:6807/4367
>> exists,up 63af2474-6d2d-46bf-8c3e-6fde1cb1e3ef
>> osd.123 up   in  weight 1 up_from 775 up_thru 833 down_at 752
>> last_clean_interval [694,751) 10.2.2.110:6845/6171
>> 10.3.2.110:6830/6171 10.3.2.110:6831/6171 10.2.2.110:6846/6171
>> exists,up a1772f6e-0067-41ec-ae9b-477f20788acb
>> osd.124 up   in  weight 1 up_from 644 up_thru 833 down_at 630
>> last_clean_interval [602,629) 10.2.3.105:6809/2913
>> 10.3.3.105:6806/2913 10.3.3.105:6807/2913 10.2.3.105:6810/2913
>> exists,up b5eb3007-f17f-4b03-8aea-2fd9cc70685d
>> osd.125 up   in  weight 1 up_from 625 up_thru 833 down_at 619
>> last_clean_interval [451,618) 10.2.1.108:6806/2877
>> 10.3.1.108:6804/2877 10.3.1.108:6805/2877 10.2.1.108:6807/2877
>> exists,up 6d7f771a-174d-4492-875c-a025574f3ade
>> osd.126 up   in  weight 1 up_from 779 up_thru 833 down_at 760
>> last_clean_interval [711,759) 10.2.2.104:6809/2977
>> 10.3.2.104:6806/2977 10.3.2.104:6807/2977 10.2.2.104:6810/2977
>> exists,up 531a8bfe-65da-4431-b261-92e7e5f41ed4
>> osd.127 up   in  weight 1 up_from 732 up_thru 833 down_at 722
>> last_clean_interval [716,721) 10.2.1.101:6800/2634
>> 10.3.1.101:6800/2634 10.3.1.101:6801/2634 10.2.1.101:6801/2634
>> exists,up bf08cf79-7719-426e-890c-90b154528302
>> osd.128 up   in  weight 1 up_from 766 up_thru 810 down_at 744
>> last_clean_interval [670,743) 10.2.3.112:6818/3837
>> 10.3.3.112:6812/3837 10.3.3.112:6813/3837 10.2.3.112:6819/3837
>> exists,up 1d1a4c8f-22c4-4fbe-ad1a-920213c54788
>> osd.129 up   in  weight 1 up_from 624 up_thru 833 down_at 615
>> last_clean_interval [466,614) 10.2.1.107:6800/2933
>> 10.3.1.107:6800/2933 10.3.1.107:6801/2933 10.2.1.107:6801/2933
>> exists,up 1873ac3e-d52a-4030-a2e8-97d10a1436c6
>> osd.130 up   in  weight 1 up_from 734 up_thru 833 down_at 727
>> last_clean_interval [717,726) 10.2.1.102:6806/2972
>> 10.3.1.102:6804/2972 10.3.1.102:6805/2972 10.2.1.102:6807/2972
>> exists,up a7688209-d8f6-46a0-902a-ec7b6061ffa8
>> osd.131 up   in  weight 1 up_from 779 up_thru 833 down_at 756
>> last_clean_interval [709,755) 10.2.2.103:6800/2956
>> 10.3.2.103:6800/2956 10.3.2.103:6801/2956 10.2.2.103:6801/2956
>> exists,up 69a79457-b529-4d25-873d-215f4b2063ae
>> osd.132 up   in  weight 1 up_from 772 up_thru 833 down_at 748
>> last_clean_interval [692,747) 10.2.2.109:6800/2987
>> 10.3.2.109:6800/2987 10.3.2.109:6801/2987 10.2.2.109:6801/2987
>> exists,up 24fcd073-8aa4-4c74-b44f-d86e007fc006
>> osd.133 up   in  weight 1 up_from 638 up_thru 833 down_at 633
>> last_clean_interval [608,632) 10.2.3.106:6800/2880
>> 10.3.3.106:6800/2880 10.3.3.106:6801/2880 10.2.3.106:6801/2880
>> exists,up f9e3ef5d-c4be-4598-9cbd-9d12bed4da02
>> osd.134 up   in  weight 1 up_from 773 up_thru 833 down_at 752
>> last_clean_interval [695,751) 10.2.2.110:6821/3086
>> 10.3.2.110:6814/3086 10.3.2.110:6815/3086 10.2.2.110:6822/3086
>> exists,up ab77c0b0-8443-4de1-aec8-ceaa09e77cd6
>> osd.135 up   in  weight 1 up_from 646 up_thru 833 down_at 630
>> last_clean_interval [594,629) 10.2.3.105:6836/4663
>> 10.3.3.105:6824/4663 10.3.3.105:6825/4663 10.2.3.105:6837/4663
>> exists,up 8bae89d3-0106-4144-a2d1-4d99b3ce0547
>> osd.136 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [663,738) 10.2.3.111:6854/6301
>> 10.3.3.111:6836/6301 10.3.3.111:6837/6301 10.2.3.111:6855/6301
>> exists,up 5016f910-01dd-4b1d-9d7d-5ceb31903720
>> osd.137 up   in  weight 1 up_from 626 up_thru 833 down_at 619
>> last_clean_interval [450,618) 10.2.1.108:6830/4218
>> 10.3.1.108:6820/4218 10.3.1.108:6821/4218 10.2.1.108:6831/4218
>> exists,up c5e4c454-0307-4922-9c67-bb8212928a34
>> osd.138 up   in  weight 1 up_from 779 up_thru 833 down_at 760
>> last_clean_interval [710,759) 10.2.2.104:6803/2945
>> 10.3.2.104:6802/2945 10.3.2.104:6803/2945 10.2.2.104:6804/2945
>> exists,up 5dd89d1f-a035-48c4-8ca6-b99b3a0afea9
>> osd.139 up   in  weight 1 up_from 735 up_thru 833 down_at 722
>> last_clean_interval [715,721) 10.2.1.101:6842/5523
>> 10.3.1.101:6828/5523 10.3.1.101:6829/5523 10.2.1.101:6843/5523
>> exists,up ff2bdb05-cb46-4ff6-9186-f70e19933337
>> osd.140 up   in  weight 1 up_from 769 up_thru 833 down_at 744
>> last_clean_interval [668,743) 10.2.3.112:6830/3902
>> 10.3.3.112:6820/3902 10.3.3.112:6821/3902 10.2.3.112:6833/3902
>> exists,up 48432e47-fabe-45a0-961c-a5399de0bd4f
>> osd.141 up   in  weight 1 up_from 734 up_thru 833 down_at 727
>> last_clean_interval [717,726) 10.2.1.102:6824/3583
>> 10.3.1.102:6816/3583 10.3.1.102:6817/3583 10.2.1.102:6825/3583
>> exists,up aed7ced3-ae30-4b4c-9e39-1f63968512e6
>> osd.142 up   in  weight 1 up_from 624 up_thru 833 down_at 615
>> last_clean_interval [469,614) 10.2.1.107:6803/2935
>> 10.3.1.107:6802/2935 10.3.1.107:6803/2935 10.2.1.107:6804/2935
>> exists,up f578ffb8-371b-43ef-ac7e-106996c7ac46
>> osd.143 up   in  weight 1 up_from 781 up_thru 833 down_at 756
>> last_clean_interval [709,755) 10.2.2.103:6851/6191
>> 10.3.2.103:6834/6191 10.3.2.103:6835/6191 10.2.2.103:6852/6191
>> exists,up 41ab004a-2465-4e16-bee3-523d97930fb5
>> osd.144 up   in  weight 1 up_from 639 up_thru 833 down_at 633
>> last_clean_interval [609,632) 10.2.3.106:6836/4432
>> 10.3.3.106:6824/4432 10.3.3.106:6825/4432 10.2.3.106:6837/4432
>> exists,up 15d1035c-fdec-40e1-9aa9-6c7ff8bdb340
>> osd.145 up   in  weight 1 up_from 647 up_thru 833 down_at 630
>> last_clean_interval [595,629) 10.2.3.105:6848/5703
>> 10.3.3.105:6832/5703 10.3.3.105:6833/5703 10.2.3.105:6849/5703
>> exists,up 347e9729-473f-4d71-b6d6-daf81bda42ac
>> osd.146 up   in  weight 1 up_from 766 up_thru 833 down_at 739
>> last_clean_interval [663,738) 10.2.3.111:6851/5826
>> 10.3.3.111:6834/5826 10.3.3.111:6835/5826 10.2.3.111:6852/5826
>> exists,up b0b33b68-3198-47a8-b28d-efe71904ffbd
>> osd.147 up   in  weight 1 up_from 733 up_thru 833 down_at 722
>> last_clean_interval [716,721) 10.2.1.101:6815/3137
>> 10.3.1.101:6810/3137 10.3.1.101:6811/3137 10.2.1.101:6816/3137
>> exists,up 84cc173f-08c9-4e47-8695-ecfbec734621
>> osd.148 up   in  weight 1 up_from 737 up_thru 833 down_at 727
>> last_clean_interval [718,726) 10.2.1.102:6857/6980
>> 10.3.1.102:6838/6980 10.3.1.102:6839/6980 10.2.1.102:6858/6980
>> exists,up 627c6077-f371-4431-afe1-ae04689d54d9
>> osd.149 up   in  weight 1 up_from 626 up_thru 833 down_at 619
>> last_clean_interval [451,618) 10.2.1.108:6833/4433
>> 10.3.1.108:6822/4433 10.3.1.108:6823/4433 10.2.1.108:6834/4433
>> exists,up cb5900ae-15ca-409b-aa34-99481bc94aa2
>> osd.150 up   in  weight 1 up_from 780 up_thru 833 down_at 760
>> last_clean_interval [713,759) 10.2.2.104:6821/3212
>> 10.3.2.104:6814/3212 10.3.2.104:6815/3212 10.2.2.104:6822/3212
>> exists,up 2fc21617-4b10-49ef-962b-71f9c9704042
>> osd.151 up   in  weight 1 up_from 627 up_thru 833 down_at 615
>> last_clean_interval [466,614) 10.2.1.107:6857/6911
>> 10.3.1.107:6838/6911 10.3.1.107:6839/6911 10.2.1.107:6858/6911
>> exists,up 2d9bfc88-4813-463a-874b-7609c49afc50
>> osd.152 up   in  weight 1 up_from 766 up_thru 833 down_at 744
>> last_clean_interval [668,743) 10.2.3.112:6832/3885
>> 10.3.3.112:6823/3885 10.3.3.112:6825/3885 10.2.3.112:6836/3885
>> exists,up e41e1246-0c2c-4349-8231-4ebd75accd13
>> osd.153 up   in  weight 1 up_from 781 up_thru 833 down_at 756
>> last_clean_interval [709,755) 10.2.2.103:6842/5438
>> 10.3.2.103:6828/5438 10.3.2.103:6829/5438 10.2.2.103:6843/5438
>> exists,up e53b93c0-0312-4f9f-b9e2-67ac5729102d
>> osd.154 up   in  weight 1 up_from 639 up_thru 810 down_at 633
>> last_clean_interval [608,632) 10.2.3.106:6827/3568
>> 10.3.3.106:6818/3568 10.3.3.106:6819/3568 10.2.3.106:6828/3568
>> exists,up 1b795ade-36eb-4a19-96be-8631949db184
>> osd.155 up   in  weight 1 up_from 646 up_thru 833 down_at 630
>> last_clean_interval [595,629) 10.2.3.105:6830/4270
>> 10.3.3.105:6820/4270 10.3.3.105:6821/4270 10.2.3.105:6831/4270
>> exists,up 8f635a5b-a3d5-4a43-a6c9-d41fa08ce2e5
>> osd.156 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [660,738) 10.2.3.111:6824/4398
>> 10.3.3.111:6816/4398 10.3.3.111:6817/4398 10.2.3.111:6825/4398
>> exists,up 7267a2b8-e8e1-47d7-b1ff-ec36adb6beba
>> osd.157 up   in  weight 1 up_from 735 up_thru 810 down_at 722
>> last_clean_interval [717,721) 10.2.1.101:6845/5751
>> 10.3.1.101:6830/5751 10.3.1.101:6831/5751 10.2.1.101:6846/5751
>> exists,up 1e286a10-7c79-4e16-addb-2a0424c4ee4f
>> osd.158 up   in  weight 1 up_from 627 up_thru 833 down_at 619
>> last_clean_interval [455,618) 10.2.1.108:6842/5368
>> 10.3.1.108:6828/5368 10.3.1.108:6829/5368 10.2.1.108:6843/5368
>> exists,up 510065f0-1f05-4ee0-959e-f9350d320f51
>> osd.159 up   in  weight 1 up_from 780 up_thru 833 down_at 760
>> last_clean_interval [711,759) 10.2.2.104:6800/2943
>> 10.3.2.104:6800/2943 10.3.2.104:6801/2943 10.2.2.104:6801/2943
>> exists,up b10ee30e-96fd-4246-816e-24e45817cab0
>> osd.160 up   in  weight 1 up_from 737 up_thru 810 down_at 727
>> last_clean_interval [719,726) 10.2.1.102:6830/4221
>> 10.3.1.102:6820/4221 10.3.1.102:6821/4221 10.2.1.102:6831/4221
>> exists,up 34e8f23a-c151-48ff-bcf6-020be21fe1dc
>> osd.161 up   in  weight 1 up_from 766 up_thru 833 down_at 744
>> last_clean_interval [672,743) 10.2.3.112:6812/3821
>> 10.3.3.112:6808/3821 10.3.3.112:6809/3821 10.2.3.112:6813/3821
>> exists,up 818641a6-e89b-4f73-8bbd-cfd4a240e5d5
>> osd.162 up   in  weight 1 up_from 626 up_thru 833 down_at 615
>> last_clean_interval [468,614) 10.2.1.107:6845/5576
>> 10.3.1.107:6830/5576 10.3.1.107:6831/5576 10.2.1.107:6846/5576
>> exists,up 4677d33f-2bb1-4d65-b169-55a7ad358927
>> osd.163 up   in  weight 1 up_from 779 up_thru 833 down_at 756
>> last_clean_interval [713,755) 10.2.2.103:6824/3487
>> 10.3.2.103:6816/3487 10.3.2.103:6817/3487 10.2.2.103:6825/3487
>> exists,up ebbddba5-5ff6-4104-a810-1787397d6a2e
>> osd.164 up   in  weight 1 up_from 641 up_thru 833 down_at 633
>> last_clean_interval [609,632) 10.2.3.106:6857/6890
>> 10.3.3.106:6838/6890 10.3.3.106:6839/6890 10.2.3.106:6858/6890
>> exists,up d1319db9-47cc-4784-954d-3c3e47d8baf5
>> osd.165 up   in  weight 1 up_from 644 up_thru 833 down_at 630
>> last_clean_interval [596,629) 10.2.3.105:6812/2998
>> 10.3.3.105:6808/2998 10.3.3.105:6809/2998 10.2.3.105:6813/2998
>> exists,up 7c872ba3-fc65-49bc-85ad-191b748e7ccb
>> osd.166 up   in  weight 1 up_from 766 up_thru 833 down_at 739
>> last_clean_interval [662,738) 10.2.3.111:6842/4476
>> 10.3.3.111:6828/4476 10.3.3.111:6829/4476 10.2.3.111:6843/4476
>> exists,up d8c569d9-ca1e-4fe7-ad8d-bfa4b20e0a0a
>> osd.167 up   in  weight 1 up_from 736 up_thru 833 down_at 722
>> last_clean_interval [716,721) 10.2.1.101:6857/6948
>> 10.3.1.101:6838/6948 10.3.1.101:6839/6948 10.2.1.101:6858/6948
>> exists,up 9b8f3ae0-26d6-4522-a600-7f847ae67ac0
>> osd.168 up   in  weight 1 up_from 734 up_thru 833 down_at 727
>> last_clean_interval [717,726) 10.2.1.102:6803/2959
>> 10.3.1.102:6802/2959 10.3.1.102:6803/2959 10.2.1.102:6804/2959
>> exists,up 64603922-ed2f-42cd-9117-57ed4bbfcdae
>> osd.169 up   in  weight 1 up_from 626 up_thru 833 down_at 619
>> last_clean_interval [454,618) 10.2.1.108:6827/3987
>> 10.3.1.108:6818/3987 10.3.1.108:6819/3987 10.2.1.108:6828/3987
>> exists,up 6c91f84b-09a7-4807-8cbc-7ef2a46dd5aa
>> osd.170 up   in  weight 1 up_from 782 up_thru 833 down_at 760
>> last_clean_interval [711,759) 10.2.2.104:6842/4977
>> 10.3.2.104:6828/4977 10.3.2.104:6829/4977 10.2.2.104:6843/4977
>> exists,up fe354752-5537-41e2-943b-f53fd66876f7
>> osd.171 up   in  weight 1 up_from 625 up_thru 833 down_at 615
>> last_clean_interval [467,614) 10.2.1.107:6836/4553
>> 10.3.1.107:6824/4553 10.3.1.107:6825/4553 10.2.1.107:6837/4553
>> exists,up 79e61ba5-929b-44bc-a49d-4a9f394d5b10
>> osd.172 up   in  weight 1 up_from 766 up_thru 833 down_at 744
>> last_clean_interval [671,743) 10.2.3.112:6815/3825
>> 10.3.3.112:6810/3825 10.3.3.112:6811/3825 10.2.3.112:6816/3825
>> exists,up cd5e2f57-bef2-4012-8b27-280da053cc63
>> osd.173 up   in  weight 1 up_from 779 up_thru 833 down_at 756
>> last_clean_interval [709,755) 10.2.2.103:6809/2962
>> 10.3.2.103:6806/2962 10.3.2.103:6807/2962 10.2.2.103:6810/2962
>> exists,up 1e57357f-cdb2-4ada-a769-5b80348007ad
>> osd.174 up   in  weight 1 up_from 637 up_thru 833 down_at 633
>> last_clean_interval [609,632) 10.2.3.106:6815/3006
>> 10.3.3.106:6810/3006 10.3.3.106:6811/3006 10.2.3.106:6816/3006
>> exists,up e7679fd2-92bd-44b4-b066-192f78ef4e6d
>> osd.175 up   in  weight 1 up_from 646 up_thru 833 down_at 630
>> last_clean_interval [598,629) 10.2.3.105:6833/4515
>> 10.3.3.105:6822/4515 10.3.3.105:6823/4515 10.2.3.105:6834/4515
>> exists,up e95a6b8d-38bd-42c6-b1f8-e003bf6ce3ef
>> osd.176 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [663,738) 10.2.3.111:6857/7030
>> 10.3.3.111:6838/7030 10.3.3.111:6839/7030 10.2.3.111:6858/7030
>> exists,up cd5baafc-38ba-4f64-ad1a-cefcf85a8641
>> osd.177 up   in  weight 1 up_from 733 up_thru 833 down_at 722
>> last_clean_interval [719,721) 10.2.1.101:6821/3493
>> 10.3.1.101:6814/3493 10.3.1.101:6815/3493 10.2.1.101:6822/3493
>> exists,up b27c404a-557c-4864-b8b1-feee49520f54
>> osd.178 up   in  weight 1 up_from 736 up_thru 833 down_at 727
>> last_clean_interval [719,726) 10.2.1.102:6842/5576
>> 10.3.1.102:6828/5576 10.3.1.102:6829/5576 10.2.1.102:6843/5576
>> exists,up 63c0ff29-42d2-461f-b876-74142fb43f7e
>> osd.179 up   in  weight 1 up_from 624 up_thru 833 down_at 615
>> last_clean_interval [467,614) 10.2.1.107:6827/3769
>> 10.3.1.107:6818/3769 10.3.1.107:6819/3769 10.2.1.107:6828/3769
>> exists,up b856af22-5af2-420b-ba6b-7b5e2bea9c63
>> osd.180 up   in  weight 1 up_from 780 up_thru 833 down_at 760
>> last_clean_interval [711,759) 10.2.2.104:6824/3478
>> 10.3.2.104:6816/3478 10.3.2.104:6817/3478 10.2.2.104:6825/3478
>> exists,up 22e1ea6d-97dd-4919-85db-cd9bff5d7e4c
>> osd.181 up   in  weight 1 up_from 766 up_thru 810 down_at 744
>> last_clean_interval [669,743) 10.2.3.112:6839/4028
>> 10.3.3.112:6826/4028 10.3.3.112:6827/4028 10.2.3.112:6840/4028
>> exists,up 077507b9-c287-4c8d-9205-877d23ac34aa
>> osd.182 up   in  weight 1 up_from 626 up_thru 833 down_at 619
>> last_clean_interval [453,618) 10.2.1.108:6839/4825
>> 10.3.1.108:6826/4825 10.3.1.108:6827/4825 10.2.1.108:6840/4825
>> exists,up 51fb0261-b23d-4c93-bf11-d2cf6615de51
>> osd.183 up   in  weight 1 up_from 780 up_thru 833 down_at 756
>> last_clean_interval [712,755) 10.2.2.103:6833/4228
>> 10.3.2.103:6822/4228 10.3.2.103:6823/4228 10.2.2.103:6834/4228
>> exists,up 46fec890-499e-4b80-b36b-0d281b506ce6
>> osd.184 up   in  weight 1 up_from 640 up_thru 833 down_at 633
>> last_clean_interval [607,632) 10.2.3.106:6845/5635
>> 10.3.3.106:6830/5635 10.3.3.106:6831/5635 10.2.3.106:6846/5635
>> exists,up 945d9843-7133-4a3b-9fd7-d6b69daba9c8
>> osd.185 up   in  weight 1 up_from 643 up_thru 833 down_at 630
>> last_clean_interval [596,629) 10.2.3.105:6800/2617
>> 10.3.3.105:6800/2617 10.3.3.105:6801/2617 10.2.3.105:6801/2617
>> exists,up c2b763aa-95de-434b-a5c3-32972bb33a9d
>> osd.186 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [663,738) 10.2.3.111:6830/4418
>> 10.3.3.111:6820/4418 10.3.3.111:6821/4418 10.2.3.111:6831/4418
>> exists,up 0ccfa09d-273e-4ef6-809e-dbf96a20c44b
>> osd.187 up   in  weight 1 up_from 733 up_thru 833 down_at 727
>> last_clean_interval [720,726) 10.2.1.102:6800/2805
>> 10.3.1.102:6800/2805 10.3.1.102:6801/2805 10.2.1.102:6801/2805
>> exists,up 16c8d09a-c305-47dd-bdc9-ba9398de59c1
>> osd.188 up   in  weight 1 up_from 625 up_thru 833 down_at 619
>> last_clean_interval [450,618) 10.2.1.108:6821/3384
>> 10.3.1.108:6814/3384 10.3.1.108:6815/3384 10.2.1.108:6822/3384
>> exists,up 2d98439a-dd78-447d-8006-fc1a2f30cada
>> osd.189 up   in  weight 1 up_from 769 up_thru 810 down_at 744
>> last_clean_interval [670,743) 10.2.3.112:6827/3882
>> 10.3.3.112:6818/3882 10.3.3.112:6819/3882 10.2.3.112:6828/3882
>> exists,up 3662ce46-99ad-4c22-b323-ca2ab51d36ab
>> osd.190 up   in  weight 1 up_from 785 up_thru 833 down_at 760
>> last_clean_interval [710,759) 10.2.2.104:6857/8883
>> 10.3.2.104:6838/8883 10.3.2.104:6839/8883 10.2.2.104:6858/8883
>> exists,up 9dcf79e9-2645-4bf2-ad20-76f7da755b0a
>> osd.191 up   in  weight 1 up_from 734 up_thru 833 down_at 722
>> last_clean_interval [718,721) 10.2.1.101:6830/4348
>> 10.3.1.101:6820/4348 10.3.1.101:6821/4348 10.2.1.101:6831/4348
>> exists,up d3924dcf-fd0c-4cc9-a85f-4534a71529ab
>> osd.192 up   in  weight 1 up_from 624 up_thru 833 down_at 615
>> last_clean_interval [465,614) 10.2.1.107:6806/2964
>> 10.3.1.107:6804/2964 10.3.1.107:6805/2964 10.2.1.107:6807/2964
>> exists,up 1765d13c-5511-4f64-ad6a-baf3ed25f948
>> osd.193 up   in  weight 1 up_from 782 up_thru 833 down_at 756
>> last_clean_interval [709,755) 10.2.2.103:6854/6787
>> 10.3.2.103:6836/6787 10.3.2.103:6837/6787 10.2.2.103:6855/6787
>> exists,up db1d062f-2298-4eb8-bcc1-b3f23a4c130a
>> osd.194 up   in  weight 1 up_from 638 up_thru 810 down_at 633
>> last_clean_interval [611,632) 10.2.3.106:6812/3002
>> 10.3.3.106:6808/3002 10.3.3.106:6809/3002 10.2.3.106:6813/3002
>> exists,up fdc505e1-1034-42e4-b161-6b730bc4c0e0
>> osd.195 up   in  weight 1 up_from 644 up_thru 833 down_at 630
>> last_clean_interval [600,629) 10.2.3.105:6806/2794
>> 10.3.3.105:6804/2794 10.3.3.105:6805/2794 10.2.3.105:6807/2794
>> exists,up 6b2d3689-723f-419a-92f3-af6a7c218bce
>> osd.196 up   in  weight 1 up_from 769 up_thru 833 down_at 739
>> last_clean_interval [662,738) 10.2.3.111:6833/4435
>> 10.3.3.111:6822/4435 10.3.3.111:6823/4435 10.2.3.111:6834/4435
>> exists,up 15adb7b5-b472-4da0-b133-a0d1e35cba87
>> osd.197 up   in  weight 1 up_from 736 up_thru 833 down_at 727
>> last_clean_interval [720,726) 10.2.1.102:6839/5380
>> 10.3.1.102:6826/5380 10.3.1.102:6827/5380 10.2.1.102:6840/5380
>> exists,up 9cbfd072-1054-4383-a796-55412dbe3417
>> osd.198 up   in  weight 1 up_from 734 up_thru 833 down_at 722
>> last_clean_interval [716,721) 10.2.1.101:6827/4166
>> 10.3.1.101:6818/4166 10.3.1.101:6819/4166 10.2.1.101:6828/4166
