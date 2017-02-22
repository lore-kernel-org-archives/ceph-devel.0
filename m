From: Wido den Hollander <wido@42on.com>
Subject: Re: mgr active s01 reboot
Date: Wed, 22 Feb 2017 14:10:59 +0100 (CET)
Message-ID: <1923511786.10744.1487769060049@ox.pcextreme.nl>
References: <A671B5D84A17214ABF7CD65106A733B212488A87@EXMB2501.ds.umcutrecht.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:48986 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbdBVNLE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2017 08:11:04 -0500
In-Reply-To: <A671B5D84A17214ABF7CD65106A733B212488A87@EXMB2501.ds.umcutrecht.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ammerlaan, A.J.G." <A.J.G.Ammerlaan@umcutrecht.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 22 februari 2017 om 13:22 schreef "Ammerlaan, A.J.G." <A.J.G.Ammerlaan@umcutrecht.nl>:
> 
> 
> Hello All,
> 
> We are running prod. now. We have configured our Ceph cluster as by guide. 
> When our active mgr, also monitoring server s01 will be shutdown, than our ceph filesystems will disappear.
> We have 3x monitor servers.
> 
> Can we do something about this, like a redundant mgr server?
> 

You only have one Metadata server running and that's causing your issues here:

fsmap e64: 1/1/1 up {0=s01=up:active}

Try spawning multiple CephFS MDS servers to make your FileSystem highly available. The standby will take over once the Active one goes down.

P.S.: Removing all other lists. The ceph-users list would have been the right location for this e-mail.

Wido

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
