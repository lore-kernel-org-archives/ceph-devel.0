From: Ilya Dryomov <ilya.dryomov-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: v0.75 released
Date: Fri, 17 Jan 2014 12:02:18 +0200
Message-ID: <CALFYKtCCs5wR7XY5Ozct_oU2Tp1v6w-3tzt8doNg4hBn9uNHJQ@mail.gmail.com>
References: <alpine.DEB.2.00.1401141941070.8325@cobra.newdream.net>
	<CALFYKtAz5G4y1RUoqJmyr5psuh1NvD=E_7qSPm7WL+8Ra_bJ5A@mail.gmail.com>
	<20140117090518.3f988b32@batzmaru.gol.ad.jp>
	<CALFYKtBizOcjv9i5EkW7HLBdsNUzBCZ1oO1ZTaDWh8cwgK-tww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALFYKtBizOcjv9i5EkW7HLBdsNUzBCZ1oO1ZTaDWh8cwgK-tww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, Jan 17, 2014 at 11:20 AM, Ilya Dryomov <ilya.dryomov-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> On Fri, Jan 17, 2014 at 2:05 AM, Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org> wrote:
>> On Thu, 16 Jan 2014 15:51:17 +0200 Ilya Dryomov wrote:
>>
>>> On Wed, Jan 15, 2014 at 5:42 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
>>> >
>>> > [...]
>>> >
>>> > * rbd: support for 4096 mapped devices, up from ~250 (Ilya Dryomov)
>>>
>>> Just a note, v0.75 simply adds some of the infrastructure, the actual
>>> support for this will arrive with kernel 3.14.  The theoretical limit
>>> is 65536 mapped devices, although I admit I haven't tried mapping more
>>> than ~4000 at once.
>>>
>> Just for clarification, this is for the client side when using the kernel
>> module, right?
>>
>> Not looking at more than about 150 devices per compute node now, but that
>> might change and there is also the case of failovers...
>
> Yes, this is how many 'rbd map ...'s a single rbd kernel module (and
> therefore a single compute node) can handle.  Kernels 3.13 and below
> can handle ~130-150, depending on the machine.

Sorry, typoed.  ~230-250.

Thanks,

                Ilya
