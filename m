From: Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RGW: removal of support for fastcgi
Date: Mon, 15 May 2017 08:44:40 -0700
Message-ID: <CADRKj5QpKnZoc_Z-RQ8bsYXwOTwKX7_Zb0JTVU3qRe_aZKOpzw@mail.gmail.com>
References: <CADRKj5SSio-vpfSBgJbEWTZC2HDqnWQsYd6K0auy-=F7PpBVeA@mail.gmail.com>
	<CALqRxCwQP4ceZyZauZhPoLJGazzvKq4BGVRtpH+t58NR5xfDMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALqRxCwQP4ceZyZauZhPoLJGazzvKq4BGVRtpH+t58NR5xfDMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, May 15, 2017 at 8:35 AM, Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Fri, May 5, 2017 at 1:51 PM, Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> TL;DR: Does anyone care if we remove support for fastcgi in rgw?
>
> Please remove it as soon as possible. The old libfcgi project's code
> is a security liability. When upstream died, there was a severe lack
> of coordination around distributing patches to fix CVE-2012-6687. I
> expect a similar level of chaos if another CVE surfaces in this
> library. There are also unanswered questions about libfcgi's continued
> use of poll vs select, see
> https://bugs.launchpad.net/ubuntu/+source/libfcgi/+bug/933417/comments/5
> .

Didn't see any compelling reason to keep it. It seems to me that the
SSL issue that Roger was pointing at could be solved either through a
different apache config, or something that we could fix (and might
have already fixed) in civetweb. As a first go I think we should still
keep the code around but not build it for Luminous.

Yehuda
