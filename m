From: Lars Marowsky-Bree <lmb-IBi9RG/b67k@public.gmane.org>
Subject: Re: who is using nfs-ganesha and cephfs?
Date: Thu, 9 Nov 2017 11:04:40 +0100
Message-ID: <20171109100440.yut3qjvejxwd7oz3@suse.com>
References: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1711082140180.29217-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 2017-11-08T21:41:41, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Who is running nfs-ganesha's FSAL to export CephFS?  What has your =

> experience been?
> =

> (We are working on building proper testing and support for this into =

> Mimic, but the ganesha FSAL has been around for years.)

We use it currently, and it works, but let's not discuss the performance
;-)

How else do you want to build this into Mimic?

Regards,
    Lars

-- =

SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton, HRB=
 21284 (AG N=FCrnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde
