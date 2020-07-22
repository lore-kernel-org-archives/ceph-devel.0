From: Ezra Ulembeck <ulembeck@gmail.com>
Subject: Problems with building/installing ceph from sources (git repo) on
 x86_64 (ubuntu 20.04)
Date: Wed, 22 Jul 2020 20:41:20 +0200
Message-ID: <cda63c29-bf9a-635f-df95-38cd04de2ced@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVSlZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jul 2020 14:41:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1E2C0619DC
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2020 11:41:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id bm28so2442993edb.2
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2020 11:41:25 -0700 (PDT)
Received: from oc4278210638.ibm.com ([2a02:8070:a1a5:8400:7e7:ba1f:70a9:f64e])
        by smtp.gmail.com with ESMTPSA id e8sm302353eja.101.2020.07.22.11.41.22
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 11:41:22 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

While following the instructions in
https://docs.ceph.com/docs/master/install/build-ceph/

1) I am not able to build packages
2) I encounter problems after building/installing in user-space

Details:

$ git clone --recursive https://github.com/ceph/ceph.git
$ cd ceph
$ git checkout octopus
$ ./install-deps.sh

1. Building packages

$ sudo dpkg-buildpackage -j4
...
/usr/bin/cc -g -O2 -fdebug-prefix-map=/home/eduard/ceph=. 
-fstack-protector-strong -Wformat -Werror=format-security -Wdate-time 
-D_FORTIFY_SOURCE=2 -DCMAKE_HAVE_LIBC_PTHREAD  -Wl,-Bsymbolic-functions 
-Wl,-z,relro  CMakeFiles/cmTC_277b6.dir/src.c.o  -o cmTC_277b6
/usr/bin/ld: CMakeFiles/cmTC_277b6.dir/src.c.o: in function `main':
./obj-x86_64-linux-gnu/CMakeFiles/CMakeTmp/./obj-x86_64-linux-gnu/CMakeFiles/CMakeTmp/src.c:11: 
undefined reference to `pthread_create'
/usr/bin/ld: 
./obj-x86_64-linux-gnu/CMakeFiles/CMakeTmp/./obj-x86_64-linux-gnu/CMakeFiles/CMakeTmp/src.c:12: 
undefined reference to `pthread_detach'
/usr/bin/ld: 
./obj-x86_64-linux-gnu/CMakeFiles/CMakeTmp/./obj-x86_64-linux-gnu/CMakeFiles/CMakeTmp/src.c:13: 
undefined reference to `pthread_join'
collect2: error: ld returned 1 exit status

2. Building/installing in user-space

$ ./do_cmake.sh
$ cd build
$ make
$ sudo make install

$ ceph -s
Traceback (most recent call last):
   File "/usr/local/bin/ceph", line 140, in <module>
     import rados
ImportError: librados.so.2: cannot open shared object file: No such file 
or directory


I will be very thankful for any hints on how to get to success,

Thanks,
Ezra
