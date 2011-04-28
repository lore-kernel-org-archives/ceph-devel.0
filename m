From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: Data replication not working
Date: Thu, 28 Apr 2011 17:10:46 +0800
Message-ID: <BANLkTik5CCdVnLhQZGRiig9sZwsnCDzyjg@mail.gmail.com>
References: <1303980121.11285.3.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54458 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab1D1JKs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 05:10:48 -0400
Received: by fxm17 with SMTP id 17so1677746fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 02:10:46 -0700 (PDT)
In-Reply-To: <1303980121.11285.3.camel@indica.cc.iitb.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ajit@iitb.ac.in
Cc: ceph-devel@vger.kernel.org

2011/4/28 Ajit K Jena <ajit@iitb.ac.in>:
> Hi All,
>
> We have been experimenting with ceph since version 0.24 and
> found one important issue that is not resolved (or may be
> we don't know how to configure properly).
>
> I will talk about 0.27 since that is the latest release:
>
> =C2=A0We have a one mon, one mds, and two osd setup. The data
> =C2=A0stored goes to both the osds. We introduce a third osd.
> =C2=A0the ceph status shows "osd: 3 up, 3 in" but no data goes
> =C2=A0into the third osd. This remains the case even if we
> =C2=A0power off one of the original osds.
>
> Data reliability thru replication is one of the major goals
> of ceph. I am wondering as to what we might be missing to
> get this feature going. I am attaching the configuration
> file.
>
> Pl help us solve this problem.
>
> Regards.
>
> --ajit
>

Hi Ajit,

The symptom looks like the crushmap has not been updated after you
introduced the third osd, so the data never goes into it. If that is
the case, you may refer to the wiki page
(http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction#Includ=
e_the_new_OSD_in_the_data_placement)
to adjust the crushmap of your cluster.

Cheers,
--
Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
