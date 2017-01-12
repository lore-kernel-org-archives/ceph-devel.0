From: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Subject: Re: RBD v1 image format ...
Date: Thu, 12 Jan 2017 12:28:58 +0900
Message-ID: <20170112122858.04de2897@batzmaru.gol.ad.jp>
References: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


Hello,

On Wed, 11 Jan 2017 11:09:46 -0500 Jason Dillaman wrote:

> I would like to propose that starting with the Luminous release of Ceph,
> RBD will no longer support the creation of v1 image format images via the
> rbd CLI and librbd.
> 
> We previously made the v2 image format the default and deprecated the v1
> format under the Jewel release. It is important to note that we would still
> support the use of v1 images by the CLI, VMs, etc for Luminous.
> 
> Any objections or concerns?
> 
As with the "deprecation" of v1, a transparent and non-downtime conversion
tool from v1 to v2 would significantly reduce the number of people who are
likely to take issue with this.

Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi-FW+hd8ioUD0@public.gmane.org   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
