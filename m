From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: What is XFS/filesystem corruption and whose fault is it?
Date: Thu, 1 Dec 2016 19:52:13 +0100 (CET)
Message-ID: <1923182119.3955394.1480618333252.JavaMail.zimbra@oxygem.tv>
References: <e7d7de6a-fd30-4957-b49d-9f3f2ae10871@suse.cz> <7F16E120-AF6C-4277-B10A-851783A8F9E8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:35388 "EHLO
        mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbcLASwe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2016 13:52:34 -0500
In-Reply-To: <7F16E120-AF6C-4277-B10A-851783A8F9E8@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Jakubiec <dan.jakubiec@gmail.com>
Cc: Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

>>That might work for XFS but it won't work for the wider Ceph cluster —
>>it's against the RADOS guarantees and expectations for an OSD to go
>>back in time after committing an update and *can* result in failure.
>>-Greg

But we have osd journals (sync writes) and it should replay on failure ?


----- Mail original -----
De: "Dan Jakubiec" <dan.jakubiec@gmail.com>
À: "Nathan Cutler" <ncutler@suse.cz>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoyé: Jeudi 1 Décembre 2016 17:04:32
Objet: Re: What is XFS/filesystem corruption and whose fault is it?

We lost a whole cluster once due to incorrect write cache settings on multiple OSDs. 

I think the recommendations on that page are correct, but I would also add that you must disable any write caching on the drive itself as well. 

The XFS FAQ is the best place I've found that explains all the ins and outs (Q24 thru Q28): 

http://xfs.org/index.php/XFS_FAQ <http://xfs.org/index.php/XFS_FAQ> 

-- Dan 

> On Nov 25, 2016, at 10:26, Nathan Cutler <ncutler@suse.cz> wrote: 
> 
> I've been doing some research on OSDs not starting after power outages, when supposedly "uncorruptible" XFS filesystems are corrupted and need repair. This led me to write the following brief blog post: 
> 
> http://smithfarm-thebrain.blogspot.cz/2016/11/what-is-xfsfilesystem-corruption-and.html 
> 
> Any comments and/or suggestions for improvement would be most welcome. 
> 
> Thanks for reading! 
> 
> Nathan 
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at http://vger.kernel.org/majordomo-info.html 

-- 
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 

