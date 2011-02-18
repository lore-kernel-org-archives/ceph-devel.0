From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: dedupe and compression in ceph
Date: Fri, 18 Feb 2011 19:02:00 +0100
Message-ID: <AANLkTinJEmyw--BR0z7P+-PnWhaof842O0PV810O4=Aw@mail.gmail.com>
References: <AANLkTinTbdiV56oYWf7CL7dr6xLSYG==01TDRvqDgrux@mail.gmail.com>
	<AANLkTimQcd9ViH=r9jxu_zCNQH_RJvGd2uef3BubEinN@mail.gmail.com>
	<230A55CC1BE841CCB6DE1BD9DFB367CD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63709 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab1BRSHv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 13:07:51 -0500
Received: by wyb28 with SMTP id 28so3935229wyb.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 10:07:50 -0800 (PST)
In-Reply-To: <230A55CC1BE841CCB6DE1BD9DFB367CD@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Kiran Patil <kirantpatil@gmail.com>, ceph-devel@vger.kernel.org

Hi,

i can confirm that in our environment we use the later option with lzo
compression turned on. So far we are happy with that configuration as
we see an average space saving rate of more or less 50% .

greetings

Stefan


On Fri, Feb 18, 2011 at 6:29 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Friday, February 18, 2011 at 5:30 AM, Kiran Patil wrote:
> Hello,
>>
>> May I know when would it be possible to use the underlying btrfs
>> features such as dedupe(offline) and compression for ceph cosds ?
>>
>> Is it possible to access btrfs features in cosd seamlessly ?
> Well, there are two ways to run Ceph on btrfs. One is to give it a ra=
w partition and tell it to set up the partition itself. I'm not sure ho=
w difficult it would be to enable these features under that situation, =
although I think it would be pretty simple.
> The other way is to just create a btrfs filesystem and point the OSD =
at a directory on that filesystem as its backend storage. In that scena=
rio you can set whatever mount options etc that you like. I'm not perso=
nally that familiar with btrfs but I imagine this should let you enable=
 whatever options you like. :)
>
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Stefan Majer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
