From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: My favorite question
Date: Tue, 26 Jul 2011 11:07:37 -0700
Message-ID: <CAF3hT9AMrbtu051uQaBAAMnfnUWrSFdBHix9FFYgzLrg42YV5g@mail.gmail.com>
References: <4E25646C.4000909@ufm.su>
	<Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>
	<4E2996DD.8040809@ufm.su>
	<CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>
	<4E2DDD1D.2040003@ufm.su>
	<CAF3hT9CZZAn7+bV02TNtSunj4zDTvfwpMkDc-NyRJMXAh85hJg@mail.gmail.com>
	<4E2E04C2.2050000@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50726 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1GZSHj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 14:07:39 -0400
Received: by gyh3 with SMTP id 3so446673gyh.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2011 11:07:38 -0700 (PDT)
In-Reply-To: <4E2E04C2.2050000@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

The log is giving me some very strange information. Can you attach all
the logs that you have to tracker issue #1340?
(http://tracker.newdream.net/issues/1340)
Thanks!
-Greg

On Mon, Jul 25, 2011 at 5:05 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 07/26/2011 01:55 AM, Gregory Farnum wrote:
>>
>> On Mon, Jul 25, 2011 at 2:16 PM, Fyodor Ustinov<ufm@ufm.su> =A0wrote=
:
>>>
>>> On 07/25/2011 11:54 PM, Gregory Farnum wrote:
>>>>
>>>> Hmmm, what are you doing with this PG? Have you been doing any
>>>> snapshots?
>>>
>>> I'm not use snapshot in ceph. Only as simple file system. And I'm n=
ot
>>> doing
>>> anything "special" or "unnatural" :)
>>
>> Drat. In that case this isn't the bug we hoped/thought it was.
>> How old is this filesystem, what version of the code are you running
>> now, and do you have OSD logging?
>
> I'm using the latest available official version for ubuntu (now - 0.3=
1, look
> forward to 0.32 :) from yours aptitude repository.
> FS created 2011-06-09 (I do not remember version number).
>
> I do not have "full" log.
>
>
> osd.5.log.7.gz:2011-07-18 14:00:25.520178 7f3b30884700 log [ERR] : 0.=
f8
> scrub stat mismatch, got 2067/2067 objects, 0/0 clones,
> 8595631307/8560758987 bytes, 8394181/8360126 kb.
> osd.5.log.7.gz:2011-07-18 14:00:25.520229 7f3b30884700 log [ERR] : 0.=
f8
> scrub 1 errors
> osd.5.log.6.gz:2011-07-19 14:00:34.185655 7f3b31085700 log [ERR] : 0.=
f8
> scrub stat mismatch, got 2074/2074 objects, 0/0 clones,
> 8624991435/8590119115 bytes, 8422853/8388798 kb.
> osd.5.log.6.gz:2011-07-19 14:00:34.185726 7f3b31085700 log [ERR] : 0.=
f8
> scrub 1 errors
>
> mon.0.log.6.gz:2011-07-19 17:26:38.478032 7fb3877d4700 mon.0@0(leader=
) e1
> handle_command mon_command(pg repair 0.f8 v 0) v1
>
> osd.5.log.6.gz:2011-07-19 17:26:38.588817 7f3b30884700 log [ERR] : 0.=
f8
> repair stat mismatch, got 2074/2074 objects, 0/0 clones,
> 8624991435/8590119115 bytes, 8422853/8388798 kb.
> osd.5.log.6.gz:2011-07-19 17:26:38.588900 7f3b30884700 log [ERR] : 0.=
f8
> repair 1 errors, 1 fixed
>
> osd.5.log.5.gz:2011-07-20 17:26:44.616686 7f3b30884700 log [ERR] : 0.=
f8
> scrub stat mismatch, got 2082/2082 objects, 0/0 clones,
> 8623673547/8658545867 bytes, 8421566/8455621 kb.
> osd.5.log.5.gz:2011-07-20 17:26:44.616740 7f3b30884700 log [ERR] : 0.=
f8
> scrub 1 errors
> osd.5.log.5.gz:2011-07-20 17:26:44.616686 7f3b30884700 log [ERR] : 0.=
f8
> scrub stat mismatch, got 2082/2082 objects, 0/0 clones,
> 8623673547/8658545867 bytes, 8421566/8455621 kb.
> osd.5.log.5.gz:2011-07-20 17:26:44.616740 7f3b30884700 log [ERR] : 0.=
f8
> scrub 1 errors
> osd.5.log.3.gz:2011-07-22 17:26:51.010097 7f3b30884700 log [ERR] : 0.=
f8
> scrub stat mismatch, got 2095/2095 objects, 0/0 clones,
> 8678199499/8713071819 bytes, 8474814/8508869 kb.
> osd.5.log.3.gz:2011-07-22 17:26:51.010153 7f3b30884700 log [ERR] : 0.=
f8
> scrub 1 errors
>
> mon.0.log.3.gz:2011-07-22 18:18:24.207401 7fb3877d4700 mon.0@0(leader=
) e1
> handle_command mon_command(pg repair 0.f8 v 0) v1
>
> osd.5.log.3.gz:2011-07-22 18:18:24.316597 7f3b30884700 log [ERR] : 0.=
f8
> repair stat mismatch, got 2095/2095 objects, 0/0 clones,
> 8678199499/8713071819 bytes, 8474814/8508869 kb.
> osd.5.log.3.gz:2011-07-22 18:18:24.316673 7f3b30884700 log [ERR] : 0.=
f8
> repair 1 errors, 1 fixed
>
> mon.0.log.3.gz:2011-07-22 18:26:00.897319 7fb3877d4700 mon.0@0(leader=
) e1
> handle_command mon_command(pg repair 0.f8 v 0) v1
>
> osd.5.log.3.gz:2011-07-22 18:26:00.997632 7f3b30884700 log [INF] : 0.=
f8
> repair ok, 0 fixed
>
> osd.5.log.2.gz:2011-07-23 08:25:44.516668 7f3b31085700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2772 !hml active+clean] =A0sending commit on
> repgather(0x7f3b1d12fe80 applied 705'2774 rep_tid=3D58199 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525313 1000000b013.00000007 [write 0~2203648=
] 0.f8
> snapc 1=3D[]) v2) 0x7f3b1c7cdd30
> osd.5.log.2.gz:2011-07-23 08:25:44.516939 7f3b30884700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2773 !hml active+clean] =A0sending commit on
> repgather(0x7f3b0d5d9270 applied 705'2775 rep_tid=3D58200 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525314 1000000b013.00000007 [write 2203648~6=
144] 0.f8
> snapc 1=3D[]) v2) 0x7f3b0d5d94b0
> osd.5.log.2.gz:2011-07-23 08:25:44.517044 7f3b31085700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2774 !hml active+clean] =A0sending commit on
> repgather(0x7f3b1c071ed0 applied 705'2776 rep_tid=3D58201 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525315 1000000b013.00000007 [write 2209792~2=
88768]
> 0.f8 snapc 1=3D[]) v2) 0x7f3b1c351c10
> osd.5.log.2.gz:2011-07-23 08:25:44.517144 7f3b31085700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2775 !hml active+clean] =A0sending commit on
> repgather(0x7f3b0ce8db70 applied 705'2777 rep_tid=3D58202 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525316 1000000b013.00000007 [write 2498560~8=
192] 0.f8
> snapc 1=3D[]) v2) 0x7f3b0d5d9840
> osd.5.log.2.gz:2011-07-23 08:25:44.517596 7f3b30884700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2776 !hml active+clean] =A0sending commit on
> repgather(0x7f3b1ceab010 applied 705'2778 rep_tid=3D58203 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525317 1000000b013.00000007 [write 2506752~8=
192] 0.f8
> snapc 1=3D[]) v2) 0x7f3b1c351980
> osd.5.log.2.gz:2011-07-23 08:25:44.517666 7f3b31085700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2777 !hml active+clean] =A0sending commit on
> repgather(0x7f3b0d5dac70 applied 705'2779 rep_tid=3D58204 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525318 1000000b013.00000007 [write 2514944~8=
192] 0.f8
> snapc 1=3D[]) v2) 0x7f3b0ceaeb50
> osd.5.log.2.gz:2011-07-23 08:25:44.517731 7f3b30884700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2778 !hml active+clean] =A0sending commit on
> repgather(0x7f3b1cc216a0 applied 705'2780 rep_tid=3D58205 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525319 1000000b013.00000007 [write 2523136~1=
6384]
> 0.f8 snapc 1=3D[]) v2) 0x7f3b1c79dd50
> osd.5.log.2.gz:2011-07-23 08:25:44.517794 7f3b31085700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2779 !hml active+clean] =A0sending commit on
> repgather(0x7f3b0d5e2370 applied 705'2781 rep_tid=3D58206 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525320 1000000b013.00000007 [write 2539520~1=
6384]
> 0.f8 snapc 1=3D[]) v2) 0x7f3b0ce917f0
> osd.5.log.2.gz:2011-07-23 08:25:44.517887 7f3b30884700 osd5 705 pg[0.=
f8( v
> 705'2782 (705'2772,705'2782] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2780 !hml active+clean] =A0sending commit on
> repgather(0x7f3b1dcdb3f0 applied 705'2782 rep_tid=3D58207 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525321 1000000b013.00000007 [write 2555904~1=
6384]
> 0.f8 snapc 1=3D[]) v2) 0x7f3b1c356ad0
> osd.5.log.2.gz:2011-07-23 08:25:44.560037 7f3b30884700 osd5 705 pg[0.=
f8( v
> 705'2783 (705'2781,705'2783] n=3D2099 ec=3D2 les/c 705/705 704/704/70=
0) [5,4]
> r=3D0 mlcod 705'2781 !hml active+clean] =A0sending commit on
> repgather(0x7f3b0d5d9d90 applied 705'2783 rep_tid=3D58208 wfack=3D wf=
disk=3D
> op=3Dosd_op(client4814.0:525322 1000000b013.00000007 [write 2572288~1=
622016]
> 0.f8 snapc 1=3D[]) v2) 0x7f3b0ceb2050
> osd.5.log.2.gz:2011-07-23 18:26:07.421820 7f3b31085700 log [INF] : 0.=
f8
> scrub ok
>
>
> WBR,
> =A0 =A0Fyodor.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
