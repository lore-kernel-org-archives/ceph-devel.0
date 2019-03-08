From: Herbert Alexander Faleiros <herbert-b2jWxOBV4z0IdKJ7tpkyPg@public.gmane.org>
Subject: Re: Failed to repair pg
Date: Fri, 8 Mar 2019 13:19:14 -0300
Message-ID: <20190308161914.GC92844@registro.br>
References: <20190307163755.GV6574@registro.br>
 <20190307173242.GB6574@registro.br>
 <ab4615ef-6064-52b6-4442-faa45cbc84f5@redhat.com>
 <20190308125224.GA92844@registro.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190308125224.GA92844-b2jWxOBV4z0IdKJ7tpkyPg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Zafman <dzafman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

[...]
> Now I have:
>
> HEALTH_ERR 5 scrub errors; Possible data damage: 1 pg inconsistent
> OSD_SCRUB_ERRORS 5 scrub errors
> PG_DAMAGED Possible data damage: 1 pg inconsistent
>     pg 2.2bb is active+clean+inconsistent, acting [36,12,80]
>
> Jumped from 3 to 5 scrub errors now.

did the same on osd.36 and a repair worked.

Health OK again.

Thank you,

--
Herbert
