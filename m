From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RBD v1 image format ...
Date: Wed, 11 Jan 2017 23:01:49 -0500
Message-ID: <CA+aFP1BOgT4rj6LLRQyJwB-egNJU5z8kdwoy+63kyf1rL4Njdw@mail.gmail.com>
References: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ@mail.gmail.com>
	<20170112122858.04de2897@batzmaru.gol.ad.jp>
	<CAHX7ARtB=TqykS0jxUBNBdW0+kS+=rbxXPn7kSAm4r7X+wuWoQ@mail.gmail.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAHX7ARtB=TqykS0jxUBNBdW0+kS+=rbxXPn7kSAm4r7X+wuWoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jan 11, 2017 at 10:43 PM, Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> +2
>  * Reduce manual operation as much as possible.
>  * A recovery tool in case that we break something which would not
> appear to us initially.

I definitely agree that this is an overdue tool and we have an
upstream feature ticket for tracking a possible solution for this [1].
We won't remove the support for interacting with v1 images before we
provide a path for migration. The Ceph core development team would
really like to drop internal support for tmap operations, which are
only utilized by RBD v1.

[1] http://tracker.ceph.com/issues/18430

-- 
Jason
