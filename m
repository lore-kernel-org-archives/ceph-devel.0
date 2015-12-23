From: "Van Leeuwen, Robert" <rovanleeuwen-ZuctOmHWJ9c@public.gmane.org>
Subject: Re: use object size of 32k rather than 4M
Date: Wed, 23 Dec 2015 12:57:06 +0000
Message-ID: <23844535-D8F2-438E-9C4B-3BE523D0157A@ebay.com>
References: <567A8CD6.10707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <567A8CD6.10707-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <14204E19106D2A4CB36097000238C078-idVjhtesxHvqlBn2x/YWAg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: hzwulibin <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


>In order to reduce the enlarge impact, we want to change the default size of the object from 4M to 32k.
>
>We know that will increase the number of the objects of one OSD and make remove process become longer.
>
>Hmm, here i want to ask your guys is there any other potential problems will 32k size have? If no obvious problem, will could dive into
>it and do more test on it.


I assume the objects on the OSDs filesystem will become 32k when you do this.
So if you have 1TB of data on one OSD you will have 31 million files == 31 million inodes 
This is excluding the directory structure which also might be significant.
If you have 10 OSDs on a server you will easily hit 310 million inodes.
You will need a LOT of memory to make sure the inodes are cached but even then looking up the inode might add significant latency.

My guess is it will be fast in the beginning but it will grind to an hold when the cluster gets fuller due to inodes no longer being in memory.

Also this does not take in any other bottlenecks you might hit in ceph which other users can probably answer better.


Cheers,
Robert van Leeuwen
