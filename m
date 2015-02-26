From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 11:43:31 -0700
Message-ID: <CAANLjFrHV2qisZwRUR3rG5RSk3CN8Q423rAXfn401P1JQTy0XA@mail.gmail.com>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
	<CAANLjFpHND2uyUvdzJ-pz4QOXp6SpYK=sD1WQz=rT-Two6izqw@mail.gmail.com>
	<alpine.DEB.2.00.1502251348170.25838@cobra.newdream.net>
	<CAANLjFovnkKRuKnUKYVRPczQZMxbrwVbDh-ygP+_-+weZtQV_w@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF915556188C@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF915556188C-rg0Al9uWSMePLz/DIDN4AEEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Deneau, Tom" <tom.deneau-5C7GfCeVMHo@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

[client.radosgw.gateway]
host = radosgw1
keyring = /etc/ceph/ceph.client.radosgw.keyring
rgw socket path = /var/run/ceph/ceph.radosgw.gateway.fastcgi.sock
log file = /var/log/radosgw/client.radosgw.gateway.log
rgw print continue = false
rgw enable ops log = false
rgw ops log rados = false
rgw ops log data backlog = 4096
rgw frontends = civetweb port=7480

This is firefly on CentOS 6 connecting to a giant cluster.
/etc/init.d/ceph-radosgw start

Just make sure the user defined in /etc/init.d/ceph-radosgw can
read/write to the files listed in the section (for us it was the
apache user).

On Thu, Feb 26, 2015 at 11:39 AM, Deneau, Tom <tom.deneau-5C7GfCeVMHo@public.gmane.org> wrote:
> Robert --
>
> We are still having trouble with this.
>
> Can you share your [client.radosgw.gateway] section of ceph.conf and
> were there any other special things to be aware of?
>
> -- Tom
>
> -----Original Message-----
> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Robert LeBlanc
> Sent: Thursday, February 26, 2015 12:27 PM
> To: Sage Weil
> Cc: Ceph-User; ceph-devel
> Subject: Re: [ceph-users] who is using radosgw with civetweb?
>
> Thanks, we were able to get it up and running very quickly. If it performs well, I don't see any reason to use Apache+fast_cgi. I don't have any problems just focusing on civetweb.
>
> On Wed, Feb 25, 2015 at 2:49 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On Wed, 25 Feb 2015, Robert LeBlanc wrote:
>>> We tried to get radosgw working with Apache + mod_fastcgi, but due to
>>> the changes in radosgw, Apache, mode_*cgi, etc and the documentation
>>> lagging and not having a lot of time to devote to it, we abandoned it.
>>> Where it the documentation for civetweb? If it is appliance like and
>>> easy to set-up, we would like to try it to offer some feedback on
>>> your question.
>>
>> In giant and hammer, it is enabled by default on port 7480.  On
>> firefly, you need to add the line
>>
>>  rgw frontends = fastcgi, civetweb port=7480
>>
>> to ceph.conf (you can of course adjust the port number if you like)
>> and radosgw will run standalone w/ no apache or anything else.
>>
>> sage
>>
>>
>>>
>>> Thanks,
>>> Robert LeBlanc
>>>
>>> On Wed, Feb 25, 2015 at 12:31 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> > Hey,
>>> >
>>> > We are considering switching to civetweb (the embedded/standalone
>>> > rgw web
>>> > server) as the primary supported RGW frontend instead of the
>>> > current apache + mod-fastcgi or mod-proxy-fcgi approach.
>>> > "Supported" here means both the primary platform the upstream
>>> > development focuses on and what the downstream Red Hat product will officially support.
>>> >
>>> > How many people are using RGW standalone using the embedded
>>> > civetweb server instead of apache?  In production?  At what scale?
>>> > What
>>> > version(s) (civetweb first appeared in firefly and we've backported
>>> > most fixes).
>>> >
>>> > Have you seen any problems?  Any other feedback?  The hope is to
>>> > (vastly) simplify deployment.
>>> >
>>> > Thanks!
>>> > sage
>>> > _______________________________________________
>>> > ceph-users mailing list
>>> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
