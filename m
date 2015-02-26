From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 11:45:40 -0700
Message-ID: <CAANLjFrHiXmxyPTOH0kEv+7MESJBwp=bXxW=Q_30R1A=8zkfyg@mail.gmail.com>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
	<54EF008C.2050706@42on.com>
	<107057245.16991.1424972320227.open-xchange@websrv>
	<183263292.17021.1424976208041.open-xchange@websrv.42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <183263292.17021.1424976208041.open-xchange-qBfc5dEdgJ8K5MCArbXFlw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

+1 for proxy. Keep the civetweb lean and mean and if people need
"extras" let the proxy handle this. Proxies are easy to set-up and a
simple example could be included in the documentation.

On Thu, Feb 26, 2015 at 11:43 AM, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org> wrote:
>
>
>> Op 26 feb. 2015 om 18:22 heeft Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> het volgende geschreven:
>>
>>> On Thu, 26 Feb 2015, Wido den Hollander wrote:
>>>> On 25-02-15 20:31, Sage Weil wrote:
>>>> Hey,
>>>>
>>>> We are considering switching to civetweb (the embedded/standalone rgw web
>>>> server) as the primary supported RGW frontend instead of the current
>>>> apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here means
>>>> both the primary platform the upstream development focuses on and what the
>>>> downstream Red Hat product will officially support.
>>>>
>>>> How many people are using RGW standalone using the embedded civetweb
>>>> server instead of apache?  In production?  At what scale?  What
>>>> version(s) (civetweb first appeared in firefly and we've backported most
>>>> fixes).
>>>>
>>>> Have you seen any problems?  Any other feedback?  The hope is to (vastly)
>>>> simplify deployment.
>>>
>>> It seems like Civetweb listens on 0.0.0.0 by default and that doesn't seem
>>> safe to me.
>>
>> Can you clarify?  Is that because people may inadvertantly run this on a
>> public host and not realize that the host is answering requests?
>>
>
> Yes, mainly. I think we should encourage users to run Apache, Nginx or Varnish as a proxy/filter in front.
>
> I'd just suggest to bind on localhost by default and let the user choose otherwise.
>
>> If we move to a world where this is the default/preferred route, this
>> seems like a good thing.. if they don't want to respond on an address they
>> can specify which IP to bind to?
>>
>
> Most services listen on localhost unless specified otherwise.
>
>>> In most deployments you'll put Apache, Nginx or Varnish in front of RGW to do
>>> the proper HTTP handling.
>>>
>>> I'd say that Civetweb should listen on 127.0.0.1:7480/[::1]:7480 by default.
>>>
>>> And make sure it listens on IPv6 by default :-)
>>
>> Yeah, +1 on IPv6:)
>>
>> sage
>>
>>
>>>
>>> Wido
>>>
>>>> Thanks!
>>>> sage
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
