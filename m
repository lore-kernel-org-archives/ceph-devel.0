From: Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [ANN] ceph-deploy 1.5.0 released!
Date: Thu, 1 May 2014 12:36:43 -0400
Message-ID: <CANtztVzfxmvYvEjPPH5Dk+zKm8KQQkcavBL4a8Rotmbie5_-QQ@mail.gmail.com>
References: <CANtztVzG-gRRENDpFES6nTK438MaH3SnpioMMxXOaPUK4-sSUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANtztVzG-gRRENDpFES6nTK438MaH3SnpioMMxXOaPUK4-sSUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

A minor issue was found while attempting to activate OSDs that has
just been fixed and released
as ceph-deploy v.1.5.1

Even if you haven't encountered this particular issue I do recommend
an upgrade anyway.


Thanks!


Alfredo

On Mon, Apr 28, 2014 at 3:17 PM, Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi All,
>
> There is a new release of ceph-deploy, the easy deployment tool for Ceph.
>
> This release comes with a few bug fixes and a few features:
>
> * implement `osd list`
> * add a status check on OSDs when deploying
> * sync local mirrors to remote hosts when installing
> * support flags and options set in cephdeploy.conf
>
> The full list of changes and fixes is documented at:
>
> http://ceph.com/ceph-deploy/docs/changelog.html#id1
>
> Make sure you update!
