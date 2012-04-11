From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Can we have mutiple OSD in a single machine
Date: Wed, 11 Apr 2012 15:55:26 +0200
Message-ID: <CAMvP8PBXneabJgTY1oimWsM21SOyapoV5zFXedJp8C5RmB89+A@mail.gmail.com>
References: <loom.20120411T093935-734@post.gmane.org> <4F853882.8010001@unilogicnetworks.net>
 <loom.20120411T143907-211@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50511 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330Ab2DKNzr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 09:55:47 -0400
Received: by gghe5 with SMTP id e5so427815ggh.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 06:55:46 -0700 (PDT)
In-Reply-To: <loom.20120411T143907-211@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If you're single machine change hostname in the cfg to be the same but
you need to change dev name to be different for each osd process on
single machine.

On Wed, Apr 11, 2012 at 2:42 PM, Madhusudhana U
<madhusudhana.u.acharya@gmail.com> wrote:
> Stefan Kleijkers <stefan <at> unilogicnetworks.net> writes:
>
>>
>> Hello,
>>
>> Yes that's no problem. I'm using that configuration for some time no=
w.
>> Just generate a config with multiple OSD clauses with the same node/=
host.
>>
>> With the newer ceph version mkcephfs is smart enough to detect the o=
sd's
>> on the same node and will generate a crushmap whereby the objects ge=
t
>> replicated to different nodes.
>>
>> I didn't see any impact on the performance (if you have enough
>> processing power, because you need more of that).
>>
>> I wanted to use just a few OSD's per node with mdraid, so I could us=
e
>> RAID6. This way I could swap a faulty disk without bringing the node
>> down. But I couldn't get it stable with mdraid.
>>
> This is how my OSD part in ceph.conf looks like
>
> [osd.0]
> =A0 =A0 =A0 =A0host =3D ceph-node-1
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sda6
>
> [osd.1]
> =A0 =A0 =A0 =A0host =3D ceph-node-2
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sda6
>
> [osd.2]
> =A0 =A0 =A0 =A0host =3D ceph-node-3
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sda6
>
> [osd.3]
> =A0 =A0 =A0 =A0host =3D ceph-node-4
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sda6
>
>
>
> Can you please help me how I can add multiple OSD in the same machine
> considering that i have 4 partition created for OSD ?
>
> I have powerful machines having 6 quad core Intel Xeon with 48G of RA=
M
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
