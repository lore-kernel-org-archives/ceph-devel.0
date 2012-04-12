From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: Partition for OSD journal
Date: Thu, 12 Apr 2012 20:12:59 +0200
Message-ID: <4F871B2B.2060006@unilogicnetworks.net>
References: <loom.20120412T181758-343@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out117.unilogicnetworks.net ([62.133.206.117]:54568 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757926Ab2DLSNE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Apr 2012 14:13:04 -0400
In-Reply-To: <loom.20120412T181758-343@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hello,

Just partition the disk, like sda1, sda2, etc and add the following to 
your config:
[osd.0]
             osd journal = /dev/sda1

[osd.1]
             osd journal = /dev/sda2

etc...

So you can point the "osd journal" to a file or to a device.

The negative side to this is you have to partition the disk and have to 
add a different option for every osd. You could fix this with udev and 
make a logical naming scheme for the device like:
/dev/osd.0.journal
/dev/osd.1.journal
etc

That way you can add to your config:
[osd]
             osd journal = /dev/osd.$id.journal

Stefan

On 04/12/2012 06:22 PM, Madhusudhana U wrote:
> Hi all,
> I read in the wiki that, to have a better performance compared to file
> under OSD data dir, we can have a seperate partition for OSD journal.
> can someone suggest me, how i can mention this in ceph.conf file ?
> I have below lines in my ceph.conf file. Is this means I already have
> a partition for OSD journal
>
> [osd]
>          osd data = /data/osd.$id
>          keyring = /etc/ceph/keyring.$name
>          osd journal = /journal/osd.$id.journal
>
> /journal is a separate partition of 20G.
>
> Thanks
> __M
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

