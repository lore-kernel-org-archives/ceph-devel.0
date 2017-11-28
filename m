From: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 09:12:56 +0100 (CET)
Message-ID: <1821337488.5487.1511856776936@ox.pcextreme.nl>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


> Op 27 november 2017 om 14:36 schreef Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> 
> 
> For the upcoming Luminous release (12.2.2), ceph-disk will be
> officially in 'deprecated' mode (bug fixes only). A large banner with
> deprecation information has been added, which will try to raise
> awareness.
> 

As much as I like ceph-volume and the work being done, is it really a good idea to use a minor release to deprecate a tool?

Can't we just introduce ceph-volume and deprecate ceph-disk at the release of M? Because when you upgrade to 12.2.2 suddenly existing integrations will have deprecation warnings being thrown at them while they haven't upgraded to a new major version.

As ceph-deploy doesn't support ceph-disk either I don't think it's a good idea to deprecate it right now.

How do others feel about this?

Wido

> We are strongly suggesting using ceph-volume for new (and old) OSD
> deployments. The only current exceptions to this are encrypted OSDs
> and FreeBSD systems
> 
> Encryption support is planned and will be coming soon to ceph-volume.
> 
> A few items to consider:
> 
> * ceph-disk is expected to be fully removed by the Mimic release
> * Existing OSDs are supported by ceph-volume. They can be "taken over" [0]
> * ceph-ansible already fully supports ceph-volume and will soon default to it
> * ceph-deploy support is planned and should be fully implemented soon
> 
> 
> [0] http://docs.ceph.com/docs/master/ceph-volume/simple/
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
