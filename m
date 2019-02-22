From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster stability
Date: Fri, 22 Feb 2019 17:44:39 +0530
Message-ID: <CANA9Uk7roX_w-dTOc5Vy9PY+Oe=KYB-457Ph7E5wYV15w3GOAQ@mail.gmail.com>
References: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw@mail.gmail.com>
 <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
 <CANA9Uk5_FfQqEbZ7O3xp4PPy=cSYUwSf-xWVM6+5WnQO6YkqmQ@mail.gmail.com>
 <CANrNMwUVupc80VWW_OKbYnH1JzB9fKRJFB7q7wVgJH9MY8fB6w@mail.gmail.com>
 <CANA9Uk5+D1GU55Goc0+TEjfYhtS8wQ0XRC-3QrSqBpEXPR9Z-g@mail.gmail.com>
 <CAA6-MF9ki_eHY=ZHwreHJ1KpB1iFrJd-+k7CeaOtTdTMBmD=DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAA6-MF9ki_eHY=ZHwreHJ1KpB1iFrJd-+k7CeaOtTdTMBmD=DA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Opps...is this really impact...will righ-away change this and test it.

On Fri, Feb 22, 2019 at 5:29 PM Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Den fre 22 feb. 2019 kl 12:35 skrev M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>
>> No seen the CPU limitation because we are using the 4 cores per osd daemon.
>> But still using "ms_crc_data = true and ms_crc_header = true". Will
>> disable these and try the performance.
>
>
> I am a bit sceptical to crc being so heavy that it would impact a CPU made after 1990..
>
> --
> May the most significant bit of your life be positive.
