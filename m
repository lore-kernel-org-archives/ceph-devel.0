From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: What is XFS/filesystem corruption and whose fault is it?
Date: Sat, 26 Nov 2016 14:56:16 +0100 (CET)
Message-ID: <1843397305.3730062.1480168576510.JavaMail.zimbra@oxygem.tv>
References: <e7d7de6a-fd30-4957-b49d-9f3f2ae10871@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:41400 "EHLO
        mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbcKZN4f (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Nov 2016 08:56:35 -0500
In-Reply-To: <e7d7de6a-fd30-4957-b49d-9f3f2ae10871@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I think writeback should not be a problem if barrier is enabled.

you can loose last x seconds of writes, but fs should not break.


Also for ssd drives, you need supercapacitor (generally present in all enterprise ssd),
to not loose datas in ssd memory buffer

----- Mail original -----
De: "Nathan Cutler" <ncutler@suse.cz>
À: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoyé: Vendredi 25 Novembre 2016 17:26:07
Objet: What is XFS/filesystem corruption and whose fault is it?

I've been doing some research on OSDs not starting after power outages, 
when supposedly "uncorruptible" XFS filesystems are corrupted and need 
repair. This led me to write the following brief blog post: 

http://smithfarm-thebrain.blogspot.cz/2016/11/what-is-xfsfilesystem-corruption-and.html 

Any comments and/or suggestions for improvement would be most welcome. 

Thanks for reading! 

Nathan 
-- 
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 

