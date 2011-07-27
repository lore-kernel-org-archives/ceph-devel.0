From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: My favorite question
Date: Wed, 27 Jul 2011 08:57:19 -0700
Message-ID: <CAF3hT9D8NnywKNFd43zHdrMC-bHXdaaESEnRfPWn=g4Qgw8UHA@mail.gmail.com>
References: <4E25646C.4000909@ufm.su>
	<Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>
	<4E2996DD.8040809@ufm.su>
	<CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>
	<4E2DDD1D.2040003@ufm.su>
	<CAF3hT9CZZAn7+bV02TNtSunj4zDTvfwpMkDc-NyRJMXAh85hJg@mail.gmail.com>
	<4E2E04C2.2050000@ufm.su>
	<CAF3hT9AMrbtu051uQaBAAMnfnUWrSFdBHix9FFYgzLrg42YV5g@mail.gmail.com>
	<4E2F0981.50504@ufm.su>
	<CAF3hT9AD+f6gEbzihUpNFKSfhALvMoPpudHDXxnmL5PRyOPZ0Q@mail.gmail.com>
	<4E2F135C.5010306@ufm.su>
	<CAF3hT9CtaCi8S56+hGpU0mn-tH1WJob081J4Bb0_Z7asPZcXdA@mail.gmail.com>
	<4E2FE2D1.8040902@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58621 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab1G0P5U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 11:57:20 -0400
Received: by gwaa18 with SMTP id a18so1140583gwa.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 08:57:19 -0700 (PDT)
In-Reply-To: <4E2FE2D1.8040902@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 27, 2011 at 3:05 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 07/27/2011 01:24 AM, Gregory Farnum wrote:
>>
>> Hmm, I'm afraid I can't see anything useful in these logs right now =
--
>> just confusion!
>>
>> The only thing I can think of that might provide useful information
>> now is to turn off osd5, update its config file to have heavy
>> debugging information (debug osd =3D 20, at a minimum), and then sta=
rt
>> the OSD back up again. Then we can see if pg 0.256 is still having a=
ny
>> issues (it is in the logs you sent me).
>>
>> If not I'll have to mark this as "Can't reproduce" and hope we see i=
t
>> again from somebody with higher log levels on. :(
>> -Greg
>
> I started manual scrubbing on osd5 and got next message:
>
> 2011-07-27 11:38:30.360812 =A0 log 2011-07-27 11:38:28.540559 osd5
> 10.5.51.145:6803/19737 2842 : [ERR] 0.256 scrub stat mismatch, got 21=
96/2196
> objects, 0/0 clones, 9046200695/9046200817 bytes, 8834197/8834197 kb.
> 2011-07-27 11:38:30.360812 =A0 log 2011-07-27 11:38:28.540571 osd5
> 10.5.51.145:6803/19737 2843 : [ERR] 0.256 scrub 1 errors
>
> "Hmmm" I said to myself.
>
> stop osd5
> fsck -fy /dev/sdb1
>
> And got:
>
> Inode 230558734, i_blocks is 8, should be 16. =A0Fix? yes
> Inode 230559279, i_blocks is 8208, should be 8200. =A0Fix? yes
> Inode 230559410, i_blocks is 40, should be 32. =A0Fix? yes
> Inode 230559527, i_blocks is 24, should be 32. =A0Fix? yes
> Inode 231342174, i_blocks is 40, should be 32. =A0Fix? yes
> Inode 231342209, i_blocks is 24, should be 32. =A0Fix? yes
>
> Ups. Familiar message. :(
>
> I login to different node and got the same.
>
> Greg, I think to catch any errors no sense. 2.6.39 have broken ext4. =
I will
> try 3.0.0 (or 3.1.0) and tell about result.
Ah, I think that would explain the errors. We'll have to get better at
identifying such things!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
