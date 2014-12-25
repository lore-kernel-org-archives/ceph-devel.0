From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: experimental features
Date: Thu, 25 Dec 2014 14:27:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412251427060.16664@cobra.newdream.net>
References: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net>
	<CAC6JEv8LVviFoNXB72gKBQ+seNVYphvpwm0QZeOwccPHr7Qatg@mail.gmail.com>
	<5481EF6B.4010901@redhat.com>
	<CAOGLoJN2wSxMgtok6aATSW5o-Abqcv2bdVo+dVfaEbG4iyiQSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAOGLoJN2wSxMgtok6aATSW5o-Abqcv2bdVo+dVfaEbG4iyiQSw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Justin Erenkrantz <justin-XWYNqclEDWm2WkX4dyxwcA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Sun, 7 Dec 2014, Justin Erenkrantz wrote:
> On Fri, Dec 5, 2014 at 12:46 PM, Mark Nelson <mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> > I'm in favor of the "allow experimental features" but instead call it:
> >
> > "ALLOW UNRECOVERABLE DATA CORRUPTING FEATURES" which makes things a little
> > more explicit. With great power comes great responsibility.
> 
> +1.
> 
> For Subversion, we utilize SVN_I_LOVE_CORRUPTED_XXX for a few options
> that can cause data corruption.  -- justin

Thanks, I think we should go for this one.

1. a generic option

 enable unrecoverable data corrupting features = foo bar baz

2. rename keyvaluestore-dev to keyvaluestore (and require 
'osd-objectstore-keyvaluestore' it be listed above).

3. include 'ms-type-async', 'filestore-zfs-snap' as experimental.  And 
whatever else we want to flag...

sage
