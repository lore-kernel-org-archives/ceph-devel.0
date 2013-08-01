From: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] Add missing buildrequires for Fedora
Date: Thu, 01 Aug 2013 15:14:08 +0200
Message-ID: <51FA5F20.8070504@bisect.de>
References: <51F770E9.6060004@logtenberg.eu>
Reply-To: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51F770E9.6060004-nLcryBYLV+bMkAkIaI5Geg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Erik Logtenberg <erik-nLcryBYLV+bMkAkIaI5Geg@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

I've opened a pull request with some additional fixes for this issue:
https://github.com/ceph/ceph/pull/478

Danny

Am 30.07.2013 09:53, schrieb Erik Logtenberg:
> Hi,
> 
> This patch adds two buildrequires to the ceph.spec file, that are needed
> to build the rpms under Fedora. Danny Al-Gaaf commented that the
> snappy-devel dependency should actually be added to the leveldb-devel
> package. I will try to get that fixed too, in the mean time, this patch
> does make sure Ceph builds on Fedora.
> 
> Signed-off-by: Erik Logtenberg <erik-nLcryBYLV+bMkAkIaI5Geg@public.gmane.org>
> ---
> 
