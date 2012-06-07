From: John Axel Eriksson <john@insane.se>
Subject: radosgw authentication problems
Date: Thu, 7 Jun 2012 09:03:00 +0200
Message-ID: <CAMmJxt+QMPoY-6WOypGjoTDjXafk_-knRUhfrsoca3zRn=YcXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55398 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2FGHDB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 03:03:01 -0400
Received: by obbtb18 with SMTP id tb18so483827obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 00:03:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi I'm new to the list.

We've been looking at Ceph as a possible replacement for our current
distributed storage system. In particular
we're interested in the object storage, so I started researching the
radosgw. It did take me some time to get setup
and the docs/wiki is missing lots of information (not pointing any
fingers, just describing my experience).

Anyway, I can't seem to actually do anything with the radosgw using
any S3-client I've tried. The one I tried first
was Fog (used in Chef for example). Fog is the "The Ruby cloud
services library", available here https://github.com/fog/fog.
=46og has support for many different cloud service providers.

Anyway with Fog I get this in RadosGW logs:

##############################

2012-06-07 06:22:33.642827 7f638bfff700 =A02 req 4:0.000108:s3:GET /::g=
etting op
2012-06-07 06:22:33.642831 7f638bfff700 =A02 req 4:0.000113:s3:GET
/:list_buckets:authorizing
2012-06-07 06:22:33.642854 7f638bfff700 20 get_obj_state:
rctx=3D0x7f637c0051e0 obj=3D.users:A state=3D0x7f637c005298
s->prefetch_data=3D0
2012-06-07 06:22:33.642863 7f638bfff700 10 moving .users+A to cache LRU=
 end
2012-06-07 06:22:33.642866 7f638bfff700 10 cache get: name=3D.users+A :=
 hit
2012-06-07 06:22:33.642872 7f638bfff700 20 get_obj_state: s->obj_tag
was set empty
2012-06-07 06:22:33.642877 7f638bfff700 10 moving .users+A to cache LRU=
 end
2012-06-07 06:22:33.642879 7f638bfff700 10 cache get: name=3D.users+A :=
 hit
2012-06-07 06:22:33.642920 7f638bfff700 10 get_canon_resource(): dest=3D=
/
2012-06-07 06:22:33.642923 7f638bfff700 10 auth_hdr:
GET


Thu, 07 Jun 2012 06:22:33 +0000
/
2012-06-07 06:22:33.642942 7f638bfff700 15 b64=3DzeK7YoQr63ajV6BRW6Z/UB=
1c4nM=3D
2012-06-07 06:22:33.642944 7f638bfff700 15
auth_sign=3DI9+abkuIjC89me95FoxmqApdrPs=3D
2012-06-07 06:22:33.642946 7f638bfff700 15 compare=3D-49
2012-06-07 06:22:33.642949 7f638bfff700 10 failed to authorize request
2012-06-07 06:22:33.642954 7f638bfff700 10 --> Status: 403

So for some reason it fails to authorize the request.

###############################

Then I moved to trying RightAws which is a different Cloud Services
Library in Ruby. Here I get a little further (because I first get a
200 response):

2012-06-07 06:24:46.006867 7fde21d66700 10 cache get: name=3D.users+A :=
 miss
2012-06-07 06:24:46.008245 7fde21d66700 10 cache put: name=3D.users+A
2012-06-07 06:24:46.008266 7fde21d66700 10 adding .users+A to cache LRU=
 end
2012-06-07 06:24:46.008276 7fde21d66700 20 get_obj_state: s->obj_tag
was set empty
2012-06-07 06:24:46.008283 7fde21d66700 10 moving .users+A to cache LRU=
 end
2012-06-07 06:24:46.008291 7fde21d66700 10 cache get: name=3D.users+A :
type miss (requested=3D1, cached=3D6)
2012-06-07 06:24:46.008301 7fde21d66700 20 get_obj_state:
rctx=3D0x7fde040055b0 obj=3D.users:A state=3D0x7fde040068b8
s->prefetch_data=3D0
2012-06-07 06:24:46.008308 7fde21d66700 10 moving .users+A to cache LRU=
 end
2012-06-07 06:24:46.008311 7fde21d66700 10 cache get: name=3D.users+A :=
 hit
2012-06-07 06:24:46.008315 7fde21d66700 20 get_obj_state: s->obj_tag
was set empty
2012-06-07 06:24:46.008320 7fde21d66700 20 get_obj_state:
rctx=3D0x7fde040055b0 obj=3D.users:A state=3D0x7fde040068b8
s->prefetch_data=3D0
2012-06-07 06:24:46.008324 7fde21d66700 20 state for obj=3D.users:A is
not atomic, not appending atomic test
2012-06-07 06:24:46.008327 7fde21d66700 20 rados->read obj-ofs=3D0
read_ofs=3D0 read_len=3D16384
2012-06-07 06:24:46.008864 7fde21d66700 20 rados->read r=3D0 bl.length=3D=
126
2012-06-07 06:24:46.008898 7fde21d66700 10 cache put: name=3D.users+A
2012-06-07 06:24:46.008901 7fde21d66700 10 moving .users+A to cache LRU=
 end
2012-06-07 06:24:46.008964 7fde21d66700 10 get_canon_resource(): dest=3D=
/
2012-06-07 06:24:46.008968 7fde21d66700 10 auth_hdr:
GET


Thu, 07 Jun 2012 06:24:46 GMT
/
2012-06-07 06:24:46.009059 7fde21d66700 15 b64=3DjpZmnXpUiWZq8IHBmsTKwK=
z4+Z4=3D
2012-06-07 06:24:46.009063 7fde21d66700 15
auth_sign=3DjpZmnXpUiWZq8IHBmsTKwKz4+Z4=3D
2012-06-07 06:24:46.009065 7fde21d66700 15 compare=3D0
2012-06-07 06:24:46.009069 7fde21d66700 =A02 req 1:0.002478:s3:GET
/:list_buckets:reading permissions
2012-06-07 06:24:46.009087 7fde21d66700 =A02 req 1:0.002496:s3:GET
/:list_buckets:verifying op permissions
2012-06-07 06:24:46.009099 7fde21d66700 =A02 req 1:0.002509:s3:GET
/:list_buckets:verifying op params
2012-06-07 06:24:46.009103 7fde21d66700 =A02 req 1:0.002513:s3:GET
/:list_buckets:executing
2012-06-07 06:24:46.009750 7fde21d66700 10 --> Status: 200

2012-06-07 06:24:46.009799 7fde21d66700 10 --> Content-Length: 318

2012-06-07 06:24:46.009803 7fde21d66700 10 --> Accept-Ranges: bytes

2012-06-07 06:24:46.009807 7fde21d66700 10 --> Content-type: applicatio=
n/xml

2012-06-07 06:24:46.009825 7fde21d66700 =A05 nothing to log for operati=
on
2012-06-07 06:24:46.009832 7fde21d66700 =A02 req 1:0.003241:s3:GET
/:list_buckets:http status=3D200

And now I do a PUT:

2012-06-07 06:24:46.018316 7fde097fa700 =A02 req 2:0.000171:s3:PUT
/johnkey::getting op
2012-06-07 06:24:46.018322 7fde097fa700 =A02 req 2:0.000177:s3:PUT
/johnkey:create_bucket:authorizing
2012-06-07 06:24:46.018346 7fde097fa700 20 get_obj_state:
rctx=3D0x7fddfc0058a0 obj=3D.users:A state=3D0x7fddfc005958
s->prefetch_data=3D0
2012-06-07 06:24:46.018356 7fde097fa700 10 moving .users+A to cache LRU=
 end
2012-06-07 06:24:46.018360 7fde097fa700 10 cache get: name=3D.users+A :
type miss (requested=3D6, cached=3D3)
2012-06-07 06:24:46.019922 7fde097fa700 10 cache put: name=3D.users+A
2012-06-07 06:24:46.019931 7fde097fa700 10 moving .users+A to cache LRU=
 end
2012-06-07 06:24:46.019940 7fde097fa700 20 get_obj_state: s->obj_tag
was set empty
2012-06-07 06:24:46.019948 7fde097fa700 10 moving .users+A to cache LRU=
 end
2012-06-07 06:24:46.019951 7fde097fa700 10 cache get: name=3D.users+A :=
 hit
2012-06-07 06:24:46.019999 7fde097fa700 10 get_canon_resource(): dest=3D=
/johnkey
2012-06-07 06:24:46.020003 7fde097fa700 10 auth_hdr:
PUT


Thu, 07 Jun 2012 06:24:46 GMT
/johnkey
2012-06-07 06:24:46.020026 7fde097fa700 15 b64=3DRPIY36txOP127RgLYseHC8=
Ua9kc=3D
2012-06-07 06:24:46.020028 7fde097fa700 15
auth_sign=3Dh020Ewm8NbfLYebWsXWkWCB6cDI=3D
2012-06-07 06:24:46.020030 7fde097fa700 15 compare=3D22
2012-06-07 06:24:46.020035 7fde097fa700 10 failed to authorize request
2012-06-07 06:24:46.020041 7fde097fa700 10 --> Status: 403

#################################

I've also tried s3cmd on the commandline which didn't work either. As
far as I've understood radosgw is supposed to be compatible with S3.

Thanks for your help!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
