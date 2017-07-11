From: Haomai Wang <haomai-p1s0O0zx/60@public.gmane.org>
Subject: Re: autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 23:17:17 +0800
Message-ID: <CACJqLyY0fhZJtDZ3ZS3OL=K6TcK_S2fPAE1uUGHPmnbuxDHmvw@mail.gmail.com>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
	<alpine.DEB.2.11.1707111507220.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1707111507220.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 11, 2017 at 11:11 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> On Tue, 11 Jul 2017, Sage Weil wrote:
>> Hi all,
>>
>> Luminous features a new 'service map' that lets rgw's (and rgw nfs
>> gateways and iscsi gateways and rbd mirror daemons and ...) advertise
>> themselves to the cluster along with some metadata (like the addresses
>> they are binding to and the services the provide).
>>
>> It should be pretty straightforward to build a service that
>> auto-configures haproxy based on this information so that you can deploy
>> an rgw front-end that dynamically reconfigures itself when additional
>> rgw's are deployed or removed.  haproxy has a facility to adjust its
>> backend configuration at runtime[1].
>>
>> Anybody interested in tackling this?  Setting up the load balancer in
>> front of rgw is one of the more annoying pieces of getting ceph up and
>> running in production and until now has been mostly treated as out of
>> scope.  It would be awesome if there was an autoconfigured service that
>> did it out of the box (and had all the right haproxy options set).
>
> [1] https://stackoverflow.com/questions/42678269/haproxy-dynamic-configuration

it looks we do more compared to before. do we need to care the
lifecycle of haproxy?  we need to manage haproxy in ceph command?

> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
