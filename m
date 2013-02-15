From: Patrick McGarry <patrick@inktank.com>
Subject: Re: OSD's DOWN ---after upgrade to 0.56.3
Date: Fri, 15 Feb 2013 09:11:10 -0500
Message-ID: <CAP8Oy=K7ZWLnKWzcZcnEBe8XuWsW9kE-nK-ECjDuYjgEj+FAUQ@mail.gmail.com>
References: <CAPhYxPzWKZhko9OBy7a-F=o3J2E2_P8EsZNuvBUTC8W7yUBJNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:36434 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3BOOLM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Feb 2013 09:11:12 -0500
Received: by mail-ee0-f53.google.com with SMTP id e53so1774677eek.26
        for <ceph-devel@vger.kernel.org>; Fri, 15 Feb 2013 06:11:11 -0800 (PST)
In-Reply-To: <CAPhYxPzWKZhko9OBy7a-F=o3J2E2_P8EsZNuvBUTC8W7yUBJNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

femi,

CC'ing ceph-user as this discussion probably belongs there.

Could you send a copy of your crushmap?  DNE is typically what we see
when someone explicitly removes an osd with something like: 'ceph osd
rm 90' (Does Not Exist).

Also, out of curiosity, how did you upgrade you cluster? One box at a
time? Take the whole thing down and upgrade everything? something
else? Just interested to see how you got to where you are.  Feel free
to stop by irc and ask for scuttlemonkey if you want a more direct
discussion.  Thanks.


Best Regards,

Patrick

On Fri, Feb 15, 2013 at 8:50 AM, femi anjorin <femi.anjorin@gmail.com> wrote:
> Hi All,
>
> Pls I got this result after i did an upgrade to 0.56.3. I'm not sure
> if its a problem with upgrade or some other things.
>
> # ceph osd tree
>
> # id    weight  type name       up/down reweight
> -1      96      root default
> -3      96              rack unknownrack
> -2      4                       host server109
> 0       1                               osd.0   DNE
> 1       1                               osd.1   DNE
> 2       1                               osd.2   DNE
> 3       1                               osd.3   up      1
> -4      4                       host server111
> 10      1                               osd.10  DNE
> 11      1                               osd.11  DNE
> 8       1                               osd.8   DNE
> 9       1                               osd.9   up      1
> -5      4                       host server112
> 12      1                               osd.12  DNE
> 13      1                               osd.13  DNE
> 14      1                               osd.14  DNE
> 15      1                               osd.15  up      1
> -6      4                       host server113
> 16      1                               osd.16  DNE
> 17      1                               osd.17  DNE
> 18      1                               osd.18  DNE
> 19      1                               osd.19  up      1
> -7      4                       host server114
> 20      1                               osd.20  DNE
> 21      1                               osd.21  DNE
> 22      1                               osd.22  DNE
> 23      1                               osd.23  up      1
> -8      4                       host server115
> 24      1                               osd.24  DNE
> 25      1                               osd.25  DNE
> 26      1                               osd.26  DNE
> 27      1                               osd.27  up      1
> -9      4                       host server116
> 28      1                               osd.28  DNE
> 29      1                               osd.29  DNE
> 30      1                               osd.30  DNE
> 31      1                               osd.31  up      1
> -10     4                       host server209
> 32      1                               osd.32  DNE
> 33      1                               osd.33  DNE
> 34      1                               osd.34  DNE
> 35      1                               osd.35  up      1
> -11     4                       host server210
> 36      1                               osd.36  DNE
> 37      1                               osd.37  DNE
> 38      1                               osd.38  DNE
> 39      1                               osd.39  up      1
> -12     4                       host server110
> 4       1                               osd.4   DNE
> 5       1                               osd.5   DNE
> 6       1                               osd.6   DNE
> 7       1                               osd.7   up      1
> -13     4                       host server211
> 40      1                               osd.40  DNE
> 41      1                               osd.41  DNE
> 42      1                               osd.42  DNE
> 43      1                               osd.43  up      1
> -14     4                       host server212
> 44      1                               osd.44  DNE
> 45      1                               osd.45  DNE
> 46      1                               osd.46  DNE
> 47      1                               osd.47  up      1
> -15     4                       host server213
> 48      1                               osd.48  DNE
> 49      1                               osd.49  DNE
> 50      1                               osd.50  DNE
> 51      1                               osd.51  up      1
> -16     4                       host server214
> 52      1                               osd.52  DNE
> 53      1                               osd.53  DNE
> 54      1                               osd.54  DNE
> 55      1                               osd.55  up      1
> -17     4                       host server215
> 56      1                               osd.56  DNE
> 57      1                               osd.57  DNE
> 58      1                               osd.58  DNE
> 59      1                               osd.59  up      1
> -18     4                       host server216
> 60      1                               osd.60  DNE
> 61      1                               osd.61  DNE
> 62      1                               osd.62  DNE
> 63      1                               osd.63  up      1
> -19     4                       host server309
> 64      1                               osd.64  DNE
> 65      1                               osd.65  DNE
> 66      1                               osd.66  DNE
> 67      1                               osd.67  up      1
> -20     4                       host server310
> 68      1                               osd.68  DNE
> 69      1                               osd.69  DNE
> 70      1                               osd.70  DNE
> 71      1                               osd.71  up      1
> -21     4                       host server311
> 72      1                               osd.72  DNE
> 73      1                               osd.73  DNE
> 74      1                               osd.74  DNE
> 75      1                               osd.75  up      1
> -22     4                       host server312
> 76      1                               osd.76  DNE
> 77      1                               osd.77  DNE
> 78      1                               osd.78  DNE
> 79      1                               osd.79  up      1
> -23     4                       host server313
> 80      1                               osd.80  DNE
> 81      1                               osd.81  DNE
> 82      1                               osd.82  DNE
> 83      1                               osd.83  up      1
> -24     4                       host server314
> 84      1                               osd.84  DNE
> 85      1                               osd.85  DNE
> 86      1                               osd.86  DNE
> 87      1                               osd.87  up      1
> -25     4                       host server315
> 88      1                               osd.88  DNE
> 89      1                               osd.89  DNE
> 90      1                               osd.90  DNE
> 91      1                               osd.91  up      1
> -26     4                       host server316
> 92      1                               osd.92  DNE
> 93      1                               osd.93  DNE
> 94      1                               osd.94  DNE
> 95      1                               osd.95  up      1
>
>
> ALTHOUGH THE HEALTH IS GOOD....
>
> # ceph health
> HEALTH_OK
>
> # ceph status
>    health HEALTH_OK
>    monmap e1: 3 mons at
> {a=172.16.0.25:6789/0,b=172.16.0.26:6789/0,c=172.16.0.24:6789/0},
> election epoch 10, quorum 0,1,2 a,b,c
>    osdmap e143: 24 osds: 24 up, 24 in
>     pgmap v2080: 18624 pgs: 18624 active+clean; 8730 bytes data, 1315
> MB used, 168 TB / 168 TB avail
>    mdsmap e9: 1/1/1 up {0=a=up:active}
>
> #  ceph osd dump
>
> epoch 143
> fsid 16cf888d-a38f-4308-84ad-300b89b9fae9
> created 2013-02-15 13:05:29.465590
> modifed 2013-02-15 13:49:40.305081
> flags
>
> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
> 6208 pgp_num 6208 last_change 1 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins
> pg_num 6208 pgp_num 6208 last_change 1 owner 0
> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num
> 6208 pgp_num 6208 last_change 1 owner 0
>
> max_osd 96
> osd.3 up   in  weight 1 up_from 67 up_thru 139 down_at 66
> last_clean_interval [3,63) 172.16.1.9:6800/6880 172.16.1.9:6803/6880
> 172.16.1.9:6804/6880 exists,up 55a33287-62d3-47d7-8eca-b479dc74677e
> osd.7 up   in  weight 1 up_from 111 up_thru 139 down_at 110
> last_clean_interval [14,108) 172.16.1.10:6803/7175
> 172.16.1.10:6804/7175 172.16.1.10:6805/7175 exists,up
> b00cbbf6-b0f0-4aa2-a1fd-5cc5c5fa3af5
> osd.9 up   in  weight 1 up_from 135 up_thru 139 down_at 134
> last_clean_interval [32,131) 172.16.1.11:6800/8520
> 172.16.1.11:6803/8520 172.16.1.11:6804/8520 exists,up
> 3300850a-f32c-4c50-bf92-d85afb576e63
> osd.15 up   in  weight 1 up_from 53 up_thru 139 down_at 52
> last_clean_interval [2,51) 172.16.1.12:6800/6679 172.16.1.12:6803/6679
> 172.16.1.12:6804/6679 exists,up 1a970009-103d-4d55-8318-63d9b30c4c36
> osd.19 up   in  weight 1 up_from 57 up_thru 139 down_at 56
> last_clean_interval [4,54) 172.16.1.13:6800/11231
> 172.16.1.13:6803/11231 172.16.1.13:6804/11231 exists,up
> 16350f84-0472-479a-92f8-98a6a6f63998
> osd.23 up   in  weight 1 up_from 60 up_thru 139 down_at 59
> last_clean_interval [4,57) 172.16.1.14:6803/6835 172.16.1.14:6804/6835
> 172.16.1.14:6805/6835 exists,up 3c3551b0-79d7-49bc-b98b-5e412e56d791
> osd.27 up   in  weight 1 up_from 65 up_thru 139 down_at 64
> last_clean_interval [4,61) 172.16.1.15:6803/11582
> 172.16.1.15:6804/11582 172.16.1.15:6805/11582 exists,up
> 034b8935-be7f-4eda-a11b-b48e9673eab4
> osd.31 up   in  weight 1 up_from 71 up_thru 139 down_at 70
> last_clean_interval [5,67) 172.16.1.16:6803/7019 172.16.1.16:6804/7019
> 172.16.1.16:6805/7019 exists,up 216774f0-d9e6-4d07-9f19-1aea5392f832
> osd.35 up   in  weight 1 up_from 74 up_thru 139 down_at 73
> last_clean_interval [3,69) 172.16.2.9:6800/6877 172.16.2.9:6803/6877
> 172.16.2.9:6804/6877 exists,up 4ec66ccf-adbb-45cf-abed-a70eff93879e
> osd.39 up   in  weight 1 up_from 78 up_thru 139 down_at 77
> last_clean_interval [4,76) 172.16.2.10:6803/11465
> 172.16.2.10:6804/11465 172.16.2.10:6805/11465 exists,up
> 79f9026b-3c56-4d9f-9a0e-046902a4cfff
> osd.43 up   in  weight 1 up_from 81 up_thru 139 down_at 80
> last_clean_interval [4,78) 172.16.2.11:6803/7007 172.16.2.11:6804/7007
> 172.16.2.11:6805/7007 exists,up 961d7332-8df3-47cd-86f2-732920373145
> osd.47 up   in  weight 1 up_from 86 up_thru 139 down_at 85
> last_clean_interval [5,81) 172.16.2.12:6803/7057 172.16.2.12:6804/7057
> 172.16.2.12:6805/7057 exists,up c9a9b167-7454-456c-8a31-05de29e7bfd9
> osd.51 up   in  weight 1 up_from 91 up_thru 139 down_at 90
> last_clean_interval [6,88) 172.16.2.13:6800/7111 172.16.2.13:6803/7111
> 172.16.2.13:6804/7111 exists,up d78e9778-0eb0-48a1-bbb0-80326decfd88
> osd.55 up   in  weight 1 up_from 95 up_thru 139 down_at 94
> last_clean_interval [7,90) 172.16.2.14:6803/7189 172.16.2.14:6804/7189
> 172.16.2.14:6805/7189 exists,up 63701034-d4bf-47e5-aebf-fbce1c9997b1
> osd.59 up   in  weight 1 up_from 99 up_thru 139 down_at 98
> last_clean_interval [10,97) 172.16.2.15:6803/7242
> 172.16.2.15:6804/7242 172.16.2.15:6805/7242 exists,up
> 7fe841dd-ddb0-4e63-bd1c-4695c273d0d3
> osd.63 up   in  weight 1 up_from 103 up_thru 139 down_at 102
> last_clean_interval [11,100) 172.16.2.16:6803/8679
> 172.16.2.16:6804/8679 172.16.2.16:6805/8679 exists,up
> 3d3f2dd7-feb2-4720-b0b2-aeb68a4c3be
> f
> osd.67 up   in  weight 1 up_from 107 up_thru 139 down_at 106
> last_clean_interval [14,101) 172.16.3.9:6803/7320 172.16.3.9:6804/7320
> 172.16.3.9:6805/7320 exists,up fb86457e-8e2f-4e3f-8537-b0a21c928e81
> osd.71 up   in  weight 1 up_from 115 up_thru 139 down_at 114
> last_clean_interval [15,109) 172.16.3.10:6803/7375
> 172.16.3.10:6804/7375 172.16.3.10:6805/7375 exists,up
> b3fa6928-8495-49de-8bac-90f4c61c1f5
> 0
> osd.75 up   in  weight 1 up_from 119 up_thru 139 down_at 118
> last_clean_interval [19,117) 172.16.3.11:6803/7473
> 172.16.3.11:6804/7473 172.16.3.11:6805/7473 exists,up
> 9f39ee19-3c17-4816-975a-ad2b895b48e
> 8
> osd.79 up   in  weight 1 up_from 121 up_thru 139 down_at 120
> last_clean_interval [24,117) 172.16.3.12:6803/7512
> 172.16.3.12:6804/7512 172.16.3.12:6805/7512 exists,up
> f41eca77-6726-4872-981c-f309082f680
> b
> osd.83 up   in  weight 1 up_from 125 up_thru 139 down_at 124
> last_clean_interval [26,123) 172.16.3.13:6803/7581
> 172.16.3.13:6804/7581 172.16.3.13:6805/7581 exists,up
> e22b3b3e-296a-46fd-b313-96769179508
> 0
> osd.87 up   in  weight 1 up_from 129 up_thru 139 down_at 128
> last_clean_interval [30,123) 172.16.3.14:6800/7624
> 172.16.3.14:6803/7624 172.16.3.14:6804/7624 exists,up
> a3f86554-283c-426a-b3f9-a8e3da227fb
> 1
> osd.91 up   in  weight 1 up_from 135 up_thru 139 down_at 134
> last_clean_interval [35,133) 172.16.3.15:6803/7685
> 172.16.3.15:6804/7685 172.16.3.15:6805/7685 exists,up
> 805b77d5-89b9-4dec-b107-9615fdacbbd
> 0
> osd.95 up   in  weight 1 up_from 139 up_thru 139 down_at 138
> last_clean_interval [35,133) 172.16.3.16:6800/7756
> 172.16.3.16:6803/7756 172.16.3.16:6804/7756 exists,up
> c909eeba-d09d-40da-9100-a88c0cf60a7
> b
>
>
>
>
> # service ceph -a restart
> === mon.a ===
> === mon.a ===
> Stopping Ceph mon.a on PROXY2...kill 11651...done
> === mon.a ===
> Starting Ceph mon.a on PROXY2...
> starting mon.a rank 1 at 172.16.0.25:6789/0 mon_data
> /var/lib/ceph/mon/ceph-a fsid 16cf888d-a38f-4308-84ad-300b89b9fae9
> === mon.b ===
> === mon.b ===
> Stopping Ceph mon.b on PROXY3...kill 26928...done
> === mon.b ===
> Starting Ceph mon.b on PROXY3...
> starting mon.b rank 2 at 172.16.0.26:6789/0 mon_data
> /var/lib/ceph/mon/ceph-b fsid 16cf888d-a38f-4308-84ad-300b89b9fae9
> === mon.c ===
> === mon.c ===
> Stopping Ceph mon.c on PROXY1...kill 17719...done
> === mon.c ===
> Starting Ceph mon.c on PROXY1...
> starting mon.c rank 0 at 172.16.0.24:6789/0 mon_data
> /var/lib/ceph/mon/ceph-c fsid 16cf888d-a38f-4308-84ad-300b89b9fae9
> === mds.a ===
> === mds.a ===
> Stopping Ceph mds.a on PROXY2...kill 11805...done
> === mds.a ===
> Starting Ceph mds.a on PROXY2...
> starting mds.a at :/0
> === osd.0 ===
> === osd.0 ===
> Stopping Ceph osd.0 on server109...done
> === osd.0 ===
> Mounting xfs on server109:/var/lib/ceph/osd/ceph-0
> Starting Ceph osd.0 on server109...
> starting osd.0 at :/0 osd_data /var/lib/ceph/osd/ceph-0 /dev/sdf
> === osd.1 ===
> === osd.1 ===
> Stopping Ceph osd.1 on server109...done
> === osd.1 ===
> Mounting xfs on server109:/var/lib/ceph/osd/ceph-1
> Starting Ceph osd.1 on server109...
> starting osd.1 at :/0 osd_data /var/lib/ceph/osd/ceph-1 /dev/sdf
> ........
> ........
> ........
> === osd.93 ===
> === osd.93 ===
> Stopping Ceph osd.93 on server316...done
> === osd.93 ===
> Mounting xfs on server316:/var/lib/ceph/osd/ceph-93
> Starting Ceph osd.93 on server316...
> starting osd.93 at :/0 osd_data /var/lib/ceph/osd/ceph-93 /dev/sdf
> === osd.94 ===
> === osd.94 ===
> Stopping Ceph osd.94 on server316...done
> === osd.94 ===
> Mounting xfs on server316:/var/lib/ceph/osd/ceph-94
> Starting Ceph osd.94 on server316...
> starting osd.94 at :/0 osd_data /var/lib/ceph/osd/ceph-94 /dev/sdf
> === osd.95 ===
> === osd.95 ===
> Stopping Ceph osd.95 on server316...kill 7110...done
> === osd.95 ===
> Mounting xfs on server316:/var/lib/ceph/osd/ceph-95
> Starting Ceph osd.95 on server316...
> starting osd.95 at :/0 osd_data /var/lib/ceph/osd/ceph-95 /dev/sdf
>
> MEANING
> when i restart the service ...it restart all OSDs (osd.0 - osd.95)
> BUT when i check which OSDs are actually up. it is 24 NOT 96.
>
> Please how should i solve the problem???
>
> Regards.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Patrick McGarry
Director, Community
Inktank

@scuttlemonkey @inktank @ceph
