From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Looking to Use Ceph
Date: Thu, 03 Jan 2013 08:43:03 -0600
Message-ID: <50E598F7.8050000@inktank.com>
References: <50E579AF.10206@sussex.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:61313 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab3ACOmz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 09:42:55 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so12916363iad.27
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 06:42:54 -0800 (PST)
In-Reply-To: <50E579AF.10206@sussex.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "emyr.james" <emyr.james@sussex.ac.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 06:29 AM, emyr.james wrote:
> Hi,
>
> I'm thinking of starting to use ceph initially for evaluation...seeing 
> how it compares to our existing lustre file system.
> One thing that I would like confirmation of is how ceph stores large 
> files. If I store a large file in CephFS is it automatically split up 
> into chunks with the various chunks stored and replicated 
> automatically across the whole cluster, or does it store the whole 
> file as one object on one individial OSD and then has individual 
> replicants of the whole file on a small number of other OSD's ? What 
> is the typical block size used if files are split up....can this be 
> configured ?
>
> Regards,
>
> Emyr
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

Hi Emry,

If you are using CephFS (ie the posix file system component), large 
files will by default be broken up into 4MB objects.  The object size is 
configurable.  Each object is distributed pseudo randomly between the 
different OSDs (though if you have a replication level > 1, object 
replicas will obey the rules defined in your crush map).  Replication is 
on a per pool basis and happens automatically.  If an OSD goes down and 
replication is used, Ceph will attempt to heal itself by redistributing 
the objects on the down OSD to the remaining ones.

For a more in-depth explanation about objects and striping, see:
http://ceph.com/docs/master/dev/file-striping/
http://ceph.com/docs/master/architecture/

One thing you should know is that Ceph's journal is similar to EXT4's 
"data=journal" mode in that data is always written to the journal before 
it goes to disk.  If I remember correctly, ldiskfs by default uses 
ext3/4's "data=ordered" mode that only writes the data once.  The upshot 
of this is that Ceph needs to do more writes for the same amount of data 
vs lustre, but there is a lower chance of data corruption as the data is 
written.  When not network bound, Ceph will likely be slower for long 
sequential writes on the same hardware vs a highly tuned lustre system, 
but theoretically is faster for short bursty traffic as writes can be 
acknowledged as soon as they hit the journal (which requires fewer seeks 
vs writing the data out to the underlying filesystem) .  By putting OSD 
journals on high-throughput SSDs, you can mitigate the sequential write 
penalties and get the best of both worlds, though you need more PCIE and 
controller throughput, and do potentially lose a bit of capacity and 
read throughput if you have to reduce your OSD count to add the SSD 
journals.  PCIE SSDs may be a very interesting solution for journals as 
the price comes down.

Thanks,
Mark
