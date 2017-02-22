From: John Spray <jspray@redhat.com>
Subject: Re: mgr active s01 reboot
Date: Wed, 22 Feb 2017 13:34:34 +0000
Message-ID: <CALe9h7f9fgxHfUXoWGZh5x8A=dvU1bKxgsEexseGrbAkb-4fNA@mail.gmail.com>
References: <A671B5D84A17214ABF7CD65106A733B212488A87@EXMB2501.ds.umcutrecht.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36434 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932470AbdBVNe4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2017 08:34:56 -0500
Received: by mail-wr0-f178.google.com with SMTP id 89so1996510wrr.3
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2017 05:34:55 -0800 (PST)
In-Reply-To: <A671B5D84A17214ABF7CD65106A733B212488A87@EXMB2501.ds.umcutrecht.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ammerlaan, A.J.G." <A.J.G.Ammerlaan@umcutrecht.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-community@ceph.com" <ceph-community@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

On Wed, Feb 22, 2017 at 12:22 PM, Ammerlaan, A.J.G.
<A.J.G.Ammerlaan@umcutrecht.nl> wrote:
> Hello All,
>
> We are running prod. now. We have configured our Ceph cluster as by guide.
> When our active mgr, also monitoring server s01 will be shutdown, than our ceph filesystems will disappear.

Your filesystem will disappear?  What do you mean?

> We have 3x monitor servers.
>
> Can we do something about this, like a redundant mgr server?

You can always run multiple ceph-mgr processes and they'll
automatically do active/standby HA.  However, that's highly unlikely
to be anything to do with any filesystem issues you're seeing.

John

>
>
>  ceph --watch-error
>     cluster 62b32e0b-90e2-4285-87f9-8dd874d3ac8f
>      health HEALTH_WARN
>             147 pgs degraded
>             11 pgs recovering
>             136 pgs recovery_wait
>             147 pgs stuck degraded
>             147 pgs stuck unclean
>             recovery 56000/2009180 objects degraded (2.787%)
>      monmap e4: 3 mons at {s01=172.30.0.1:6789/0,s02=172.30.0.2:6789/0,s03=172.30.0.3:6789/0}
>             election epoch 74, quorum 0,1,2 s01,s02,s03
>       fsmap e64: 1/1/1 up {0=s01=up:active}
>         mgr active: s01
>      osdmap e1972: 110 osds: 110 up, 110 in
>             flags sortbitwise,require_jewel_osds,require_kraken_osds
>       pgmap v5998490: 6370 pgs, 10 pools, 3591 GB data, 981 kobjects
>             7324 GB used, 342 TB / 349 TB avail
>             56000/2009180 objects degraded (2.787%)
>                 6223 active+clean
>                  136 active+recovery_wait+degraded
>                   11 active+recovering+degraded
> recovery io 204 MB/s, 95 keys/s, 59 objects/s
>
> Regards, Arnoud.
>
> ------------------------------------------------------------------------------
>
> De informatie opgenomen in dit bericht kan vertrouwelijk zijn en is
> uitsluitend bestemd voor de geadresseerde. Indien u dit bericht onterecht
> ontvangt, wordt u verzocht de inhoud niet te gebruiken en de afzender direct
> te informeren door het bericht te retourneren. Het Universitair Medisch
> Centrum Utrecht is een publiekrechtelijke rechtspersoon in de zin van de W.H.W.
> (Wet Hoger Onderwijs en Wetenschappelijk Onderzoek) en staat geregistreerd bij
> de Kamer van Koophandel voor Midden-Nederland onder nr. 30244197.
>
> Denk s.v.p aan het milieu voor u deze e-mail afdrukt.
>
> ------------------------------------------------------------------------------
>
> This message may contain confidential information and is intended exclusively
> for the addressee. If you receive this message unintentionally, please do not
> use the contents but notify the sender immediately by return e-mail. University
> Medical Center Utrecht is a legal person by public law and is registered at
> the Chamber of Commerce for Midden-Nederland under no. 30244197.
>
> Please consider the environment before printing this e-mail.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
