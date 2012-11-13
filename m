From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: OSD hardware suggestion
Date: Tue, 13 Nov 2012 00:02:26 -0800
Message-ID: <50A1FE92.1040007@inktank.com>
References: <CAJH6TXha_jTHocYATAHY_EYqo5zCT1rwtg9jxv6XkAg6mwPH-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:33155 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab2KMIC3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 03:02:29 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so3108645dak.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 00:02:29 -0800 (PST)
In-Reply-To: <CAJH6TXha_jTHocYATAHY_EYqo5zCT1rwtg9jxv6XkAg6mwPH-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 11/09/2012 05:11 AM, Gandalf Corvotempesta wrote:
> Based on your experience, will the following configuration be ok for a
> production cluster?
>   - R515 12 disks + 2 internal disks
>
> I'll start with 2x or 4x 2TB SATA disks in each R515. One OSD for each
> disk, 3 servers.
> Each R515 will have one internal SSD to be used as journal (single,
> huge, filesystem) shared by all OSDs and one SATA 10k RPM (probably WD
> Raptor) to be used as operating system and mons storage.

I'd suggest partitioning the SSD and using those raw block devices as
journals to avoid the overhead of an fs.

> On each R515 i'll put OSDs and one mon node.
>
> Actually, i'll use only RBD and RGW, so no need for MDS. When CephFS
> will be stable, i'll put MDS on each node.
>
> Any suggestion/advice ?

You'll be better off with more nodes so that when 1 dies, 1/3 of your
data doesn't need to be re-replicated.

Josh
