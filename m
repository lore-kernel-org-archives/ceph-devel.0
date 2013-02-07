From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Ceph RBD Client Filesystem Benchmarks
Date: Wed, 06 Feb 2013 19:57:35 -0800
Message-ID: <5113262F.3080201@inktank.com>
References: <033E32DA143A5344982E0EEF039D899B1C1CCBB7@BigThunder.catnet.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:44892 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374Ab3BGD5j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 22:57:39 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so2463534iaj.6
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 19:57:39 -0800 (PST)
In-Reply-To: <033E32DA143A5344982E0EEF039D899B1C1CCBB7@BigThunder.catnet.arizona.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Michel, Adam K - (amichel)" <amichel@email.arizona.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks for the work, Adam!

On 02/06/2013 03:18 PM, Michel, Adam K - (amichel) wrote:
> I did some testing against an RBD device in my local environment to suss out differences between a few filesystem options. Folks in #ceph thought this data might be interesting to some on the list, so I'm posting a link to my spreadsheet here.
>
> http://mirrors.arizona.edu/ceph-devel/oxide-rbd-benches.xlsx
>
> My ceph cluster layout is pretty simple. I have one server node with all the OSDs. It's a backblaze-style pod with 40 drives, 1 OSD per drive, dual-core i3 at 3GHz, 16GB of RAM and small SSD for system disk. It's running Ubuntu 12.04 and attached with 10GbE to a switch in my lab. I have three mons on older Dell hardware, 2950s, dual quad-core E5345 Xeon, 32GB of RAM. They're running CentOS6 (needed support for the QL CNAs I had available) attached with 10GbE internal to the lab as well. I can provide ceph configuration data if anyone would like, but I followed the documentation pretty religiously so I expect it is quite vanilla. The client I used for testing is a VMware VM running Ubuntu 12.04 in a different environment (ran out of hardware in the lab) which has a 1GbE bottleneck in its 
 path to the lab.
>
> I created a 5TB rbd (it is theoretically going to end up in use in a pilot for a dropbox-style service for our campus, thus the rather strangely large size for testing) and mapped it to the client, created a GPT partition table with a single primary partition starting at sector 8192 (on guidance from someone in #ceph) and then formatted it with filesystem defaults for each of ext4, xfs and btrfs. I mounted with no special options in all cases.
>
> I ran bonnie++ v1.97 with the option to skip char tests. For iozone I tested record sizes up to 4096 on default max file size of 512M. I've generated all the standard 3d charts for the iozone results in their respective sheets to the right of their matching data tables.
>
> I make no particular claims to have done this as well as possible and would appreciate any feedback from the list on any kind of testing rubric that might generate data of more use to the community at large. This particular round of testing was mostly for my own edification.
>
> Hopefully some of you find this useful!
>
> Cheers,
> Adam
>
> --
> Adam Michel
> Systems Administrator
> UITS, University of Arizona
> amichel@arizona.edu
> 5206262189
>
