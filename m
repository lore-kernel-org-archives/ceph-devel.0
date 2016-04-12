From: Michael Metz-Martini | SpeedPartner GmbH <metz-nNLO/KQnRccYk8zSAXK5OQ@public.gmane.org>
Subject: Re: Deprecating ext4 support
Date: Tue, 12 Apr 2016 09:00:19 +0200
Message-ID: <570C9D03.6020701@speedpartner.de>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1604111632520.13448-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

Am 11.04.2016 um 23:39 schrieb Sage Weil:
> ext4 has never been recommended, but we did test it.  After Jewel is out, 
> we would like explicitly recommend *against* ext4 and stop testing it.
Hmmm. We're currently migrating away from xfs as we had some strange
performance-issues which were resolved / got better by switching to
ext4. We think this is related to our high number of objects (4358
Mobjects according to ceph -s).


> Recently we discovered an issue with the long object name handling
> that is not fixable without rewriting a significant chunk of
> FileStores filename handling.  (There is a limit in the amount of
> xattr data ext4 can store in the inode, which causes problems in
> LFNIndex.)
We're only using cephfs so we shouldn't be affected by your discovered
bug, right?


-- 
Kind regards
 Michael
