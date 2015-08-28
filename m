From: Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: =?utf-8?q?S3=EF=BC=9APermissions_of_access-key?=
Date: Fri, 28 Aug 2015 08:24:12 -0700
Message-ID: <CADRKj5StOdRYGkWq=bH3SmPoArJ+zPxFAys1qxDDO28mRQQ4wQ@mail.gmail.com>
References: <1C8B8335F613C640A5D49490DFDC782A478375DB@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1C8B8335F613C640A5D49490DFDC782A478375DB-JwQOC20i6vT3cnzPNjVLboSsE/coCuR8pWgKQ6/u3Fg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Zhengqiankun <zheng.qiankun-vVzyEvZLFYE@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Aug 28, 2015 at 2:17 AM, Zhengqiankun <zheng.qiankun-vVzyEvZLFYE@public.gmane.org> wrote:
> hi,Yehuda:
>
>       I have a question and hope that you can help me answer it. Different
> subuser of swift
>
>   can set specific permissions, but why not set specific permission for
> access-key of s3?
>

Probably because no one ever asked it. It shouldn't be hard to do
this, sounds like an easy starter project if anyone wants to get their
hands dirty in the rgw code. Note that the canonical way to do it in
S3 is through user policies that we don't (yet?) support.

Yehuda
