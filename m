From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: Data replication not working
Date: Fri, 29 Apr 2011 15:55:14 +0800
Message-ID: <BANLkTim3ybYpAPDLxr9C-sM-owO3ajYvnQ@mail.gmail.com>
References: <1303980121.11285.3.camel@indica.cc.iitb.ac.in>
	<BANLkTik5CCdVnLhQZGRiig9sZwsnCDzyjg@mail.gmail.com>
	<1303987194.12689.4.camel@indica.cc.iitb.ac.in>
	<BANLkTinfGGXL9=hFGYGa6RAXPXPBOgViSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46208 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab1D2HzP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 03:55:15 -0400
Received: by fxm17 with SMTP id 17so2339194fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2011 00:55:14 -0700 (PDT)
In-Reply-To: <BANLkTinfGGXL9=hFGYGa6RAXPXPBOgViSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: ajit@iitb.ac.in, ceph-devel@vger.kernel.org

> I have almost the same problem.
> my cluster before: 1mon, 2 mds, 3 osd=EF=BC=88osd-00,osd-01,osd-02=EF=
=BC=89
> when i want to add the fourth osd, osd-03, i did:
> mon-00 # ceph mon getmap -o /opt/cluster_debug/monmap
> osd-03 #=C2=A0cosd -c /etc/ceph/ceph.conf -i 3 --mkfs --monmap /root/=
monmap
> mon-00 #=C2=A0ceph osd setmaxosd 4
> osd-03 #=C2=A0service ceph start osd3
> =C2=A0=C2=A0=C2=A0ceph osd getcrushmap -o /opt/cluster_debug/crushmap
>
> =C2=A0crushtool -d /opt/cluster_debug/crushmap -o /opt/cluster_debug/=
crushmap.txt
>
> =C2=A0vim /opt/cluster_debug/crushmap.txt
>
> =C2=A0 crushtool -c /opt/cluster_debug/crushmap.txt -o
> /opt/cluster_debug/crushmap.new
>
> =C2=A0 ceph osd setcrushmap -i /opt/cluster_debug/crushmap.new
>
> [root@mon-00 ~]# ceph osd stat
>
> 2011-04-29 03:25:31.039361 mon <- [osd,stat]
>
> 2011-04-29 03:25:31.039790 mon0 -> 'e8: 4 osds: 4 up, 4 in' (0)
>
> but no data was migrated to osd-03, =C2=A0additionally, process cosd =
on all 4 osd
> disappeared!!!
>
> Attachment is the new crushmap.
>

Your crushmap is not correct. You should add an entry: "item device3
weight 1.000" in domain root.

--=20
Henry Chang
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
