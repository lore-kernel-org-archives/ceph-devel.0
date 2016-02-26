From: kefu chai <tchaikov@gmail.com>
Subject: Re: vstart and Python bindings
Date: Fri, 26 Feb 2016 16:38:43 +0800
Message-ID: <CAJE9aOMq3dyDkSnvDaWgzHHaNTFvKao=2TYnkkk2ZhL729AaaA@mail.gmail.com>
References: <20160224233718.6a8c7569@lembas.zaitcev.lan>
	<56CEA76D.9040200@dachary.org>
	<20160225172704.134e9480@lembas.zaitcev.lan>
	<56CFD792.5080001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34824 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbcBZIio (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Feb 2016 03:38:44 -0500
Received: by mail-yk0-f174.google.com with SMTP id r207so33345967ykd.2
        for <ceph-devel@vger.kernel.org>; Fri, 26 Feb 2016 00:38:43 -0800 (PST)
In-Reply-To: <56CFD792.5080001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Pete Zaitcev <zaitcev@redhat.com>

On Fri, Feb 26, 2016 at 12:41 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Pete,
>
> I know too little about cython to answer usefully I'm afraid. I'll let other, more knowledgeable developers answer to this problem.
>
> Cheers
>
> On 26/02/2016 07:27, Pete Zaitcev wrote:
>> Dear Loic:
>>
>> The PR 7792 is not the problem. The issue appears to be that cythonization
>> is not performed (anymore). There's a coupld of Makefile.am files in
>> src/pybind, but no relevant Makefile files are generated. I tried to make
>> it more explicit with this:
>>
>> ./configure --with-rados --with-cython --with-radosgw
>>
>> Still no effect.

Pete, i use cythan and cmake. but the autotool case is sort of similar
when "ceph" cli is launched in the source tree. i am wondering if you
are building ceph out of source? which might break the way how "ceph"
detects the library and pybind python script paths. in the "ceph"
script, it is using a heuristic way to see if it is located in
$top_srcdir/src directory or in the $CMAKE_BINARY_DIR by checking the
fulle path of "__file__" and the content of CMakeCache.txt in $PWD.

in my case, the pybind path is correctly detected as
"/home/kefu/dev/ceph/src/pybind", and is appened to sys.path in
python.  see respawn_in_path() method in the ceph cli. maybe you can
tweak it a little bit to fit your needs. for example to adjust the
ceph.in so it is able to detect the $top_srcdir in a better way when
we are build ceph out of source tree? if that's your case.


-- 
Regards
Kefu Chai
