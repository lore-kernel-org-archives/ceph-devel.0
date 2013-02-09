From: Wido den Hollander <wido@42on.com>
Subject: Re: Unable to mount cephfs - can't read superblock
Date: Sat, 09 Feb 2013 11:42:57 +0100
Message-ID: <51162831.1070506@42on.com>
References: <kf5920$1de$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:37091 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab3BIKm7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Feb 2013 05:42:59 -0500
In-Reply-To: <kf5920$1de$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: ceph-devel@vger.kernel.org

On 02/09/2013 11:40 AM, Adam Nielsen wrote:
> Hi again,
>
> I'm trying to mount my new Ceph volume on a remote PC using cephfs.
> I've followed the quick start guide, but when I try to mount the
> filesystem I get this:
>
> remote$ mount -t ceph 192.168.0.6:6789:/ /mnt/ceph/
> mount: 192.168.0.6:6789:/: can't read superblock
>
> remote$ dmesg | tail
> [951382.981690] libceph: client4105 fsid
> aa447ff8-8270-491b-b59e-2735e852eaf5
> [951382.983486] libceph: mon0 192.168.0.6:6789 session established
>
> I'm not sure what the problem is.  The osd, mon and mds daemons are
> running on the Ceph host and no traffic is firewalled between the two
> machines.  I have disabled authentication in ceph.conf.  The only issue
> I can see is this:
>
> cephhost$ ceph health
> HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean
>

Could you show the output of "ceph -s"

Also, which version of Ceph are you using under which OS?

Wido

> I'm not sure what that means as I have only used mkcephfs and then
> started the ceph service.  I haven't actually used it yet so I'm not
> sure where the unclean pgs are coming from.  The underlying filesystem
> is ext4 though.
>
> I'm a bit stuck as to what to do next.  I can't see why the filesystem
> won't mount remotely, and the troubleshooting docs say unclean pgs are
> related to outages which doesn't seem possible on a newly created volume
> with only one osd/mon/mds instance.
>
> Any pointers would be much appreciated!
>
> Many thanks,
> Adam.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
