From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Haven't been paying attention: Gperf missing
Date: Mon, 22 May 2017 19:27:08 +1000
Message-ID: <CAF-wwdFP4Wy-4Bx+wkW=btjCQokTW3QaLSaVudJJyBM=2XmaLA@mail.gmail.com>
References: <9cc2b255-f617-e109-b9b9-23a32ea8509f@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35827 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757390AbdEVJ1J (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 May 2017 05:27:09 -0400
Received: by mail-io0-f173.google.com with SMTP id f102so77048267ioi.2
        for <ceph-devel@vger.kernel.org>; Mon, 22 May 2017 02:27:09 -0700 (PDT)
In-Reply-To: <9cc2b255-f617-e109-b9b9-23a32ea8509f@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 22, 2017 at 6:16 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> But from the things below gperf is now an essential requirement?
>
> --WjW
>
> -- Check if the system is big endian - little endian
> -- Found PythonInterp: /usr/local/bin/python2.7 (found version "2.7.13")
> -- Boost version: 1.64.0
> CMake Error at src/rgw/CMakeLists.txt:30 (message):
>   Can't find gperf

https://github.com/ceph/ceph/commit/6761a838a3750998ffc0e315d429168858a80a0a

>
>
> -- Configuring incomplete, errors occurred!
> See also
> "/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMakeOutput.log".
> See also "/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMa
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
