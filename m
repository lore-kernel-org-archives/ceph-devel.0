From: Dan Mick <dmick@redhat.com>
Subject: Re: Jenkins build pestered by 'no such option:
 --disable-pip-version-check'
Date: Tue, 19 Jul 2016 20:21:50 -0700
Message-ID: <578EEE4E.7010102@redhat.com>
References: <65d919f9-a015-4fe8-b578-b2fc275494de@digiware.nl>
 <CAC-Np1xhGOo9JUcVm=4yqhN7FJJVFwxrGPXs30Rhw6a5ava_sg@mail.gmail.com>
 <04152f22-d98e-4c17-6ad4-8895b4d8682b@digiware.nl>
 <f4d2f173-00e7-47f6-2de7-d1ffc6b8837f@redhat.com>
 <2fc90487-18f9-31af-ab8e-ada88e2b01e7@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60873 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbcGTDVw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jul 2016 23:21:52 -0400
In-Reply-To: <2fc90487-18f9-31af-ab8e-ada88e2b01e7@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, dang@redhat.com, Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> Well the problem is, that it is not me that has an old version of pip.
> But this is in Jenkins and that is on the test environment where there
> is fetched fresh very test-build.
> I would not know how to influence this?

It looks as though one massive commit in
https://github.com/ceph/ceph/pull/10283 included a fix that should
resolve this.  Perhaps pull that into your branch?
