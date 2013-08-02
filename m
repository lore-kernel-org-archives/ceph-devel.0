From: Eric Eastman <eric0e-YDxpq3io04c@public.gmane.org>
Subject: Re: ceph-deploy progress and CDS session
Date: Fri, 2 Aug 2013 15:44:43 -0400 (EDT)
Message-ID: <8D05DCFDE66279C-C34-1DCE1@webmail-m101.sysops.aol.com>
References: <alpine.DEB.2.00.1308021100150.22864@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1308021100150.22864-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

First I would like to state that with all its limitiation, I have 
managed to build multiple
clusters with ceph-deploy and without it, I would have been totally 
lost.  Things
that I feel would improve it include:

A debug mode where it lists everything it is doing.  This will be 
helpful in the future
when I move to a more integrated tool then ceph-deploy, as I could see 
exactly
how ceph-deploy built my test cluster.

To understand more types of linux storage devices. I have spent hours 
trying to make it
understand multipath devices, as I happen to have a large number of 
these in my lab,
but so far I have not made it work.

Really good documentation on all the ceph-deploy options.

Lastly, this is not just a ceph-deploy thing, but documentation 
explaining how things
boot up, and interact.  Ceph-deploy depends on tools like ceph-disk to 
mount OSD
disks on the servers during boot, and I learned the hard way that if a 
OSD is on a LUN
that is seen by more then one OSD node, you can corrupt data, as each 
OSD node
tries to mount all the ODS it can find.

>There is a session at CDS scheduled to discuss ceph-deploy (4:40pm PDT 
on
>Monday).  We'll be going over what we currently have in backlog for
>improvements, but if you have any opinions about what else ceph-deploy
>should or should not do or areas where it is problematic, please reply 
to
>this thread to let us know what you think, and/or join the CDS 
discussion
>hangout.


Thank
Eric
