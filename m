From: kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: C++17 and C++ ABI on master
Date: Tue, 9 Jan 2018 21:46:55 +0800
Message-ID: <CAJE9aOMBa3DmDUKPGjVobiFNspif94zv2t-zjcRO8RjSRC=2xg@mail.gmail.com>
References: <20180108214425.GA10545@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1801082213050.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1801082213050.24931-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, The Exoteric Order of the Squid Cybernetic <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jan 9, 2018 at 6:14 AM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> On Mon, 8 Jan 2018, Adam C. Emerson wrote:
>> Good day,
>>
>> I've just merged some changs into master that set us up to compile
>> with C++17. This will require a reasonably new compiler to build
>> master.
>
> Yay!
>
>> Due to a change in how 'noexcept' is handled (it is now part of the type
>> signature of a function), mangled symbol names of noexcept functions are
>> different, so if you have custom clients using the C++ libraries, you may
>> need to recompile.
>>
>> Do not worry, there should be no change to the C ABI. Any C clients
>> should be unaffected.
>
> I added cards to the backlog for libradospp, librbdpp, and libcephfspp.

librados and librdb are a little bit complicated. most part of its C++
API is implemented using its C API and underlying RadosClient. but
there are couple C functions, which are implemented using librados'
public C++ interface. for example, IoCtx::from_rados_ioctx_t() is used
by rados_lock_exclusive(). the same applies to librbd. so we need to
decouple the C and C++ API so that they do not depend on each other. i
have a wip branch at
https://github.com/tchaikov/ceph/tree/wip-librados-cxx, in case anyone
would like to take a look. or, we can go with another route: to hide
all the C++ symbols in librados. and expose all C and C++ symbols in
its C++ counterpart. this turns this problem a symbol visibility
problem. but the downside of this solution is that we will have two
copies of APIs in each compiled library.

> Anybody out there interested in working on that?  libcephfspp might be the
> one to start with since it doesn't depend on librados and is a much
> simpler API.

libcephfs is a pure C API. so i think there is no need to split out a
C++ library from it.

>
> sage
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Regards
Kefu Chai
