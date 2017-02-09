From: Dave Holland <dh3-5fLPn3lgkryFxr2TtlUqVg@public.gmane.org>
Subject: Re: would people mind a slow osd restart during
 luminous upgrade?
Date: Thu, 9 Feb 2017 11:36:19 +0000
Message-ID: <20170209113618.GU10317@sanger.ac.uk>
References: <alpine.DEB.2.11.1702090302470.7782@piezo.novalocal>
	<24cb8bc3-bda5-467c-b2cb-e9d77ba24679@kirneh.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <24cb8bc3-bda5-467c-b2cb-e9d77ba24679-eal8BvkdEKCHXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Henrik Korkuc <lists-eal8BvkdEKCHXe+LvDLADg@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Feb 09, 2017 at 10:41:44AM +0200, Henrik Korkuc wrote:
> On 17-02-09 05:09, Sage Weil wrote:
> >Does this concern anyone?  It probably means the upgrades will take longer
> >if you're going host by host since the time per host will go up.
> In my opinion if this is clearly communicated (release notes + OSD logs)

+1 for having the OSD log something when it starts the upgrade
process, so the sysadmin who goes looking will see what's happening.

Cheers,
Dave
-- 
** Dave Holland ** Systems Support -- Informatics Systems Group **
** 01223 496923 ** The Sanger Institute, Hinxton, Cambridge, UK **


-- 
 The Wellcome Trust Sanger Institute is operated by Genome Research 
 Limited, a charity registered in England with number 1021457 and a 
 company registered in England with number 2742969, whose registered 
 office is 215 Euston Road, London, NW1 2BE. 
