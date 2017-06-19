From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Caught the first erroneous translated errorcode
Date: Mon, 19 Jun 2017 08:56:56 -0400
Message-ID: <CA+aFP1BST9e4UV6kyxP=kLN0tN0=1EkV=41cBV2Y5d98hrED7A@mail.gmail.com>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
 <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com>
 <5ca934f2-0f95-bb6c-0fce-267468cb59b4@digiware.nl> <028757af-a82b-d873-648d-294961984bbb@digiware.nl>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35311 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbdFSM45 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jun 2017 08:56:57 -0400
Received: by mail-yw0-f175.google.com with SMTP id v7so40030730ywc.2
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 05:56:57 -0700 (PDT)
In-Reply-To: <028757af-a82b-d873-648d-294961984bbb@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

On Sun, Jun 18, 2017 at 1:18 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> librbd/io/AioCompletion.cc:199:ssize_t AioCompletion::get_return_value() {


librbd just wraps librados, so I would think all the error codes
should have already been properly translated before it reaches this
level since otherwise any internal librbd error logging will output
the incorrect failure reason. I'd suspect most of the client-side
handling should probably be handled inside osdc/Objecter.h/cc..

-- 
Jason
