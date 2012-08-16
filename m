From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: host settings in ceph.conf when ipaddress != hostname
Date: Thu, 16 Aug 2012 16:13:24 -0400
Message-ID: <CACkq2mqjp-bgQ1XpdB1b7ApRRV_GtKivf_D9Tj9CXO==rFg4nA@mail.gmail.com>
References: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
 <CADvuQRFZRwL4oBvJW2H25VFME3pTk4rDZxr4WzwMT=sp-K8h6g@mail.gmail.com> <502D51D4.5010606@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:42558 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030432Ab2HPUNp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 16:13:45 -0400
Received: by qaas11 with SMTP id s11so952425qaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 13:13:44 -0700 (PDT)
In-Reply-To: <502D51D4.5010606@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Smart Weblications GmbH <info@smart-weblications.de>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

Thanks for the responses.

Is there a link to the docs where the config file options for
public_network, cluster_network, mon host, cluster addr are listed and
explained?  I looked for them, but couldn't find anything. I just come
across different mailing list entries and blog entries that keep using
options I've never seen before.  I expected to find these options
here: http://ceph.com/docs/master/config-cluster/ceph-conf/  but no
luck.

Looking at a blog post like this:
http://www.sebastien-han.fr/blog/2012/07/29/tip-ceph-public-slash-priva=
te-network-configuration/,
I become more confused.  Obviously I don't understand the relationship
between OSD and MONs correctly.  If I place all my OSDs on a private
network and the MONs on a public one, how do clients reach the OSDs?
I didn't think that data was funneled through the MONs.  Is that
incorrect?  I thought my OSDs had to be reachable by anyone trying to
mount/map an RBD, for example.

 - Travis

2012/8/16 Smart Weblications GmbH <info@smart-weblications.de>:
> Am 16.08.2012 21:56, schrieb Tommi Virtanen:
>
>> It sounds like you want to set set public_network and cluster_networ=
k
>> in [global] both to 10.30.0.0/8.
>
> 10.0.0.0/8 or 10.30.0.0/16, nor? ;-)
>
>
> --
>
> Mit freundlichen Gr=FC=DFen,
>
>
> Smart Weblications GmbH
> Martinsberger Str. 1
> D-95119 Naila
>
> fon.: +49 9282 9638 200
> fax.: +49 9282 9638 205
> 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> http://www.smart-weblications.de
>
> --
> Sitz der Gesellschaft: Naila
> Gesch=E4ftsf=FChrer: Florian Wiessner
> HRB-Nr.: HRB 3840 Amtsgericht Hof
> *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
