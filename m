From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: My favorite question
Date: Tue, 26 Jul 2011 03:05:22 +0300
Message-ID: <4E2E04C2.2050000@ufm.su>
References: <4E25646C.4000909@ufm.su>	<Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>	<4E2996DD.8040809@ufm.su>	<CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>	<4E2DDD1D.2040003@ufm.su> <CAF3hT9CZZAn7+bV02TNtSunj4zDTvfwpMkDc-NyRJMXAh85hJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:39235 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab1GZAFY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jul 2011 20:05:24 -0400
In-Reply-To: <CAF3hT9CZZAn7+bV02TNtSunj4zDTvfwpMkDc-NyRJMXAh85hJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2011 01:55 AM, Gregory Farnum wrote:
> On Mon, Jul 25, 2011 at 2:16 PM, Fyodor Ustinov<ufm@ufm.su>  wrote:
>> On 07/25/2011 11:54 PM, Gregory Farnum wrote:
>>> Hmmm, what are you doing with this PG? Have you been doing any snapshots?
>> I'm not use snapshot in ceph. Only as simple file system. And I'm not doing
>> anything "special" or "unnatural" :)
> Drat. In that case this isn't the bug we hoped/thought it was.
> How old is this filesystem, what version of the code are you running
> now, and do you have OSD logging?

I'm using the latest available official version for ubuntu (now - 0.31, look forward to 0.32 :) from yours aptitude repository.
FS created 2011-06-09 (I do not remember version number).

I do not have "full" log.


osd.5.log.7.gz:2011-07-18 14:00:25.520178 7f3b30884700 log [ERR] : 0.f8 scrub stat mismatch, got 2067/2067 objects, 0/0 clones, 8595631307/8560758987 bytes, 8394181/8360126 kb.
osd.5.log.7.gz:2011-07-18 14:00:25.520229 7f3b30884700 log [ERR] : 0.f8 scrub 1 errors
osd.5.log.6.gz:2011-07-19 14:00:34.185655 7f3b31085700 log [ERR] : 0.f8 scrub stat mismatch, got 2074/2074 objects, 0/0 clones, 8624991435/8590119115 bytes, 8422853/8388798 kb.
osd.5.log.6.gz:2011-07-19 14:00:34.185726 7f3b31085700 log [ERR] : 0.f8 scrub 1 errors

mon.0.log.6.gz:2011-07-19 17:26:38.478032 7fb3877d4700 mon.0@0(leader) e1 handle_command mon_command(pg repair 0.f8 v 0) v1

osd.5.log.6.gz:2011-07-19 17:26:38.588817 7f3b30884700 log [ERR] : 0.f8 repair stat mismatch, got 2074/2074 objects, 0/0 clones, 8624991435/8590119115 bytes, 8422853/8388798 kb.
osd.5.log.6.gz:2011-07-19 17:26:38.588900 7f3b30884700 log [ERR] : 0.f8 repair 1 errors, 1 fixed

osd.5.log.5.gz:2011-07-20 17:26:44.616686 7f3b30884700 log [ERR] : 0.f8 scrub stat mismatch, got 2082/2082 objects, 0/0 clones, 8623673547/8658545867 bytes, 8421566/8455621 kb.
osd.5.log.5.gz:2011-07-20 17:26:44.616740 7f3b30884700 log [ERR] : 0.f8 scrub 1 errors
osd.5.log.5.gz:2011-07-20 17:26:44.616686 7f3b30884700 log [ERR] : 0.f8 scrub stat mismatch, got 2082/2082 objects, 0/0 clones, 8623673547/8658545867 bytes, 8421566/8455621 kb.
osd.5.log.5.gz:2011-07-20 17:26:44.616740 7f3b30884700 log [ERR] : 0.f8 scrub 1 errors
osd.5.log.3.gz:2011-07-22 17:26:51.010097 7f3b30884700 log [ERR] : 0.f8 scrub stat mismatch, got 2095/2095 objects, 0/0 clones, 8678199499/8713071819 bytes, 8474814/8508869 kb.
osd.5.log.3.gz:2011-07-22 17:26:51.010153 7f3b30884700 log [ERR] : 0.f8 scrub 1 errors

mon.0.log.3.gz:2011-07-22 18:18:24.207401 7fb3877d4700 mon.0@0(leader) e1 handle_command mon_command(pg repair 0.f8 v 0) v1

osd.5.log.3.gz:2011-07-22 18:18:24.316597 7f3b30884700 log [ERR] : 0.f8 repair stat mismatch, got 2095/2095 objects, 0/0 clones, 8678199499/8713071819 bytes, 8474814/8508869 kb.
osd.5.log.3.gz:2011-07-22 18:18:24.316673 7f3b30884700 log [ERR] : 0.f8 repair 1 errors, 1 fixed

mon.0.log.3.gz:2011-07-22 18:26:00.897319 7fb3877d4700 mon.0@0(leader) e1 handle_command mon_command(pg repair 0.f8 v 0) v1

osd.5.log.3.gz:2011-07-22 18:26:00.997632 7f3b30884700 log [INF] : 0.f8 repair ok, 0 fixed

osd.5.log.2.gz:2011-07-23 08:25:44.516668 7f3b31085700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2772 !hml active+clean]  sending commit on repgather(0x7f3b1d12fe80 applied 705'2774 rep_tid=58199 wfack= wfdisk= op=osd_op(client4814.0:525313 1000000b013.00000007 [write 0~2203648] 0.f8 snapc 1=[]) v2) 0x7f3b1c7cdd30
osd.5.log.2.gz:2011-07-23 08:25:44.516939 7f3b30884700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2773 !hml active+clean]  sending commit on repgather(0x7f3b0d5d9270 applied 705'2775 rep_tid=58200 wfack= wfdisk= op=osd_op(client4814.0:525314 1000000b013.00000007 [write 2203648~6144] 0.f8 snapc 1=[]) v2) 0x7f3b0d5d94b0
osd.5.log.2.gz:2011-07-23 08:25:44.517044 7f3b31085700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2774 !hml active+clean]  sending commit on repgather(0x7f3b1c071ed0 applied 705'2776 rep_tid=58201 wfack= wfdisk= op=osd_op(client4814.0:525315 1000000b013.00000007 [write 2209792~288768] 0.f8 snapc 1=[]) v2) 0x7f3b1c351c10
osd.5.log.2.gz:2011-07-23 08:25:44.517144 7f3b31085700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2775 !hml active+clean]  sending commit on repgather(0x7f3b0ce8db70 applied 705'2777 rep_tid=58202 wfack= wfdisk= op=osd_op(client4814.0:525316 1000000b013.00000007 [write 2498560~8192] 0.f8 snapc 1=[]) v2) 0x7f3b0d5d9840
osd.5.log.2.gz:2011-07-23 08:25:44.517596 7f3b30884700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2776 !hml active+clean]  sending commit on repgather(0x7f3b1ceab010 applied 705'2778 rep_tid=58203 wfack= wfdisk= op=osd_op(client4814.0:525317 1000000b013.00000007 [write 2506752~8192] 0.f8 snapc 1=[]) v2) 0x7f3b1c351980
osd.5.log.2.gz:2011-07-23 08:25:44.517666 7f3b31085700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2777 !hml active+clean]  sending commit on repgather(0x7f3b0d5dac70 applied 705'2779 rep_tid=58204 wfack= wfdisk= op=osd_op(client4814.0:525318 1000000b013.00000007 [write 2514944~8192] 0.f8 snapc 1=[]) v2) 0x7f3b0ceaeb50
osd.5.log.2.gz:2011-07-23 08:25:44.517731 7f3b30884700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2778 !hml active+clean]  sending commit on repgather(0x7f3b1cc216a0 applied 705'2780 rep_tid=58205 wfack= wfdisk= op=osd_op(client4814.0:525319 1000000b013.00000007 [write 2523136~16384] 0.f8 snapc 1=[]) v2) 0x7f3b1c79dd50
osd.5.log.2.gz:2011-07-23 08:25:44.517794 7f3b31085700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2779 !hml active+clean]  sending commit on repgather(0x7f3b0d5e2370 applied 705'2781 rep_tid=58206 wfack= wfdisk= op=osd_op(client4814.0:525320 1000000b013.00000007 [write 2539520~16384] 0.f8 snapc 1=[]) v2) 0x7f3b0ce917f0
osd.5.log.2.gz:2011-07-23 08:25:44.517887 7f3b30884700 osd5 705 pg[0.f8( v 705'2782 (705'2772,705'2782] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2780 !hml active+clean]  sending commit on repgather(0x7f3b1dcdb3f0 applied 705'2782 rep_tid=58207 wfack= wfdisk= op=osd_op(client4814.0:525321 1000000b013.00000007 [write 2555904~16384] 0.f8 snapc 1=[]) v2) 0x7f3b1c356ad0
osd.5.log.2.gz:2011-07-23 08:25:44.560037 7f3b30884700 osd5 705 pg[0.f8( v 705'2783 (705'2781,705'2783] n=2099 ec=2 les/c 705/705 704/704/700) [5,4] r=0 mlcod 705'2781 !hml active+clean]  sending commit on repgather(0x7f3b0d5d9d90 applied 705'2783 rep_tid=58208 wfack= wfdisk= op=osd_op(client4814.0:525322 1000000b013.00000007 [write 2572288~1622016] 0.f8 snapc 1=[]) v2) 0x7f3b0ceb2050
osd.5.log.2.gz:2011-07-23 18:26:07.421820 7f3b31085700 log [INF] : 0.f8 scrub ok


WBR,
     Fyodor.


