From: Peter Maloney <peter.maloney-bU717sqhW2kTELwDM1PSjyEWGD4kr0XT@public.gmane.org>
Subject: Re: removing cluster name support
Date: Sun, 11 Jun 2017 15:41:34 +0200
Message-ID: <224421e8-759c-4e78-8ac1-4547d8ee3553@brockmann-consult.de>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1706081936570.3646-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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

On 06/08/17 21:37, Sage Weil wrote:
> Questions:
>
>  - Does anybody on the list use a non-default cluster name?
>  - If so, do you have a reason not to switch back to 'ceph'?
>
> Thanks!
> sage
Will it still be possible for clients to use multiple clusters?

Also how does this affect rbd mirroring?
