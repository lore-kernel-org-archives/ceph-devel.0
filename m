From: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Subject: Re: v0.75 released
Date: Fri, 17 Jan 2014 09:05:18 +0900
Message-ID: <20140117090518.3f988b32@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.00.1401141941070.8325@cobra.newdream.net>
	<CALFYKtAz5G4y1RUoqJmyr5psuh1NvD=E_7qSPm7WL+8Ra_bJ5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALFYKtAz5G4y1RUoqJmyr5psuh1NvD=E_7qSPm7WL+8Ra_bJ5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 16 Jan 2014 15:51:17 +0200 Ilya Dryomov wrote:

> On Wed, Jan 15, 2014 at 5:42 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> >
> > [...]
> >
> > * rbd: support for 4096 mapped devices, up from ~250 (Ilya Dryomov)
> 
> Just a note, v0.75 simply adds some of the infrastructure, the actual
> support for this will arrive with kernel 3.14.  The theoretical limit
> is 65536 mapped devices, although I admit I haven't tried mapping more
> than ~4000 at once.
> 
Just for clarification, this is for the client side when using the kernel
module, right?

Not looking at more than about 150 devices per compute node now, but that
might change and there is also the case of failovers...

Regards,

Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi-FW+hd8ioUD0@public.gmane.org   	Global OnLine Japan/Fusion Communications
http://www.gol.com/
