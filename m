From: Peter Maloney <peter.maloney-bU717sqhW2kTELwDM1PSjyEWGD4kr0XT@public.gmane.org>
Subject: Re: dropping filestore+btrfs testing for luminous
Date: Fri, 30 Jun 2017 12:27:41 +0200
Message-ID: <d79ce219-cf56-b6aa-7bbb-927e61e90324@brockmann-consult.de>
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1706300314120.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 06/30/17 05:21, Sage Weil wrote:
> We're having a series of problems with the valgrind included in xenial[1] 
> that have led us to restrict all valgrind tests to centos nodes.  At teh 
> same time, we're also seeing spurious ENOSPC errors from btrfs on both 
> centos on xenial kernels[2], making trusty the only distro where btrfs 
> works reliably.
Do you guys know about balance filters and how to use them to prevent
ENOSPC?

see: https://btrfs.wiki.kernel.org/index.php/Balance_Filters

Basically it sometimes (when using snaps heavily) just has many
partially used chunks and so you rebalance the data inside them so it
can remove the fully empty ones and reuse the space. The above page says
to run commands like:

> btrfs balance start -dusage=50 /

where you start at 50 or so and raise it up and rerun if you want, until
you reclaimed enough space.

So, to make the automated tests eat less of your time, you could script
something that runs that after some number of unit tests, or in the
btrfs filestore itself can do it after removing some amount of
snapshots, or after ENOSPC and retry. I don't know what's easy to
implement, just making sure you're aware of the option.
