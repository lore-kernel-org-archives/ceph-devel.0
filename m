From: Casey Bodley <cbodley-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [swift][ironic][ceph][radosgw] radosgw
 "support" in python-swiftclient droped for ocata and above
Date: Wed, 9 May 2018 11:40:47 -0400
Message-ID: <4125568e-af78-15ea-d664-749db5ce3d63@redhat.com>
References: <20180509152244.75ihypuvaxqv7cw6@gentoo.org>
Reply-To: "OpenStack Development Mailing List \(not for usage questions\)"
 <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5690600611864871679=="
Return-path: <openstack-dev-bounces-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180509152244.75ihypuvaxqv7cw6-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.openstack.org/cgi-bin/mailman/options/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openstack.org/pipermail/openstack-dev/>
List-Post: <mailto:openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Errors-To: openstack-dev-bounces-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
To: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>, Matthew Thode <prometheanfire-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============5690600611864871679==
Content-Type: multipart/alternative;
 boundary="------------568922E56EA3CF9750EAF7BD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------568922E56EA3CF9750EAF7BD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 05/09/2018 11:22 AM, Matthew Thode wrote:
> python-swiftclient prior to 3.2.0 seemed to incidentally support radosgw
> tempurls.  That is, there was no official support, but it still worked.
>
> In 3.2.0 (specifically the linked commit(s)) tempurls were validated to
> require /v1/account/container/object, which does not work with radosgw
> as it expects /v1/container/object.  This means that radosgw tempurls
> fail to work, which further means that radosgw will stop working for
> things like ironic.
>
> I can see the point that swiftclient should not care about ceph not
> fully implementing the swift spec and not supporting the radosgw url
> syntax, but it seems like a step back.  If this is not fixed then things
> like ironic will not work with radosgw for Ocata and above (as that's
> when this change was made).  We'd need to wait for either ceph to fix
> this and support the account part of the url (probably just dropping it)
> or have people fork python-swiftclient to 'fix' it.
>
> I'm not sure what the right answer is...
>
> https://github.com/openstack/python-swiftclient/commit/4c955751d340a8f71a2eebdb3c58d90b36874a66
> https://github.com/openstack/ironic/blob/214b694f05d200ac1e2ce6db631546f2831c01f7/ironic/common/glance_service/v2/image_service.py#L152-L185
>
> https://bugs.launchpad.net/ironic/+bug/1747384
>
>
>
> __________________________________________________________________________
> OpenStack Development Mailing List (not for usage questions)
> Unsubscribe: OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe
> http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev

Thanks for raising the issue. Radosgw does have a config option 
'rgw_swift_account_in_url' to expect this url format, though it defaults 
to false and I'm not 100% sure that it applies correctly to tempurls.

--------------568922E56EA3CF9750EAF7BD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <div class="moz-cite-prefix">On 05/09/2018 11:22 AM, Matthew Thode
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180509152244.75ihypuvaxqv7cw6-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org">
      <pre wrap="">python-swiftclient prior to 3.2.0 seemed to incidentally support radosgw
tempurls.  That is, there was no official support, but it still worked.

In 3.2.0 (specifically the linked commit(s)) tempurls were validated to
require /v1/account/container/object, which does not work with radosgw
as it expects /v1/container/object.  This means that radosgw tempurls
fail to work, which further means that radosgw will stop working for
things like ironic.

I can see the point that swiftclient should not care about ceph not
fully implementing the swift spec and not supporting the radosgw url
syntax, but it seems like a step back.  If this is not fixed then things
like ironic will not work with radosgw for Ocata and above (as that's
when this change was made).  We'd need to wait for either ceph to fix
this and support the account part of the url (probably just dropping it)
or have people fork python-swiftclient to 'fix' it.

I'm not sure what the right answer is...

<a class="moz-txt-link-freetext" href="https://github.com/openstack/python-swiftclient/commit/4c955751d340a8f71a2eebdb3c58d90b36874a66">https://github.com/openstack/python-swiftclient/commit/4c955751d340a8f71a2eebdb3c58d90b36874a66</a>
<a class="moz-txt-link-freetext" href="https://github.com/openstack/ironic/blob/214b694f05d200ac1e2ce6db631546f2831c01f7/ironic/common/glance_service/v2/image_service.py#L152-L185">https://github.com/openstack/ironic/blob/214b694f05d200ac1e2ce6db631546f2831c01f7/ironic/common/glance_service/v2/image_service.py#L152-L185</a>

<a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ironic/+bug/1747384">https://bugs.launchpad.net/ironic/+bug/1747384</a>

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">__________________________________________________________________________
OpenStack Development Mailing List (not for usage questions)
Unsubscribe: <a class="moz-txt-link-abbreviated" href="mailto:OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe">OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe</a>
<a class="moz-txt-link-freetext" href="http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev">http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev</a>
</pre>
    </blockquote>
    <br>
    Thanks for raising the issue. Radosgw does have a config option
    'rgw_swift_account_in_url' to expect this url format, though it
    defaults to false and I'm not 100% sure that it applies correctly to
    tempurls.<br>
  </body>
</html>

--------------568922E56EA3CF9750EAF7BD--


--===============5690600611864871679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KT3BlblN0YWNrIERldmVsb3BtZW50IE1haWxpbmcgTGlzdCAobm90
IGZvciB1c2FnZSBxdWVzdGlvbnMpClVuc3Vic2NyaWJlOiBPcGVuU3RhY2stZGV2LXJlcXVlc3RA
bGlzdHMub3BlbnN0YWNrLm9yZz9zdWJqZWN0OnVuc3Vic2NyaWJlCmh0dHA6Ly9saXN0cy5vcGVu
c3RhY2sub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9vcGVuc3RhY2stZGV2Cg==

--===============5690600611864871679==--
