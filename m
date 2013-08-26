From: Samuel Just <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: bucket count limit
Date: Mon, 26 Aug 2013 13:52:29 -0700
Message-ID: <CA+4uBUamJiB7FDX8tXg60SDMq8Vh+7OT0uXSypho=HpUFtV5XQ@mail.gmail.com>
References: <ADBDB4FFB0814748AF32D0A1EE6E10AF22835B2EFE@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <ADBDB4FFB0814748AF32D0A1EE6E10AF22835B2EFE-K9pFWFEelezFe27LHpJFGNHuzzzSOjJt@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Mostowiec Dominik <Dominik.Mostowiec-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>, Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

As I understand it, that should actually help avoid bucket contention
and thereby increase performance.

Yehuda, anything to add?
-Sam

On Thu, Aug 22, 2013 at 7:08 AM, Mostowiec Dominik
<Dominik.Mostowiec-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org> wrote:
> Hi,
>
> I think about sharding s3 buckets in CEPH cluster, create bucket-per-XX (256
> buckets) or even bucket-per-XXX (4096 buckets) where XXX is sign from object
> md5 url.
>
> Could this be the problem? (performance, or some limits)
>
>
>
> --
>
> Regards
>
> Dominik
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
