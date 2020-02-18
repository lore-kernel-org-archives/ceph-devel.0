From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 09/44] docs: filesystems: convert ceph.txt to ReST
Date: Tue, 18 Feb 2020 06:57:44 -0500
Message-ID: <988af69f85385384738c8a656335e385a3ded827.camel@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
         <df2f142b5ca5842e030d8209482dfd62dcbe020f.1581955849.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <df2f142b5ca5842e030d8209482dfd62dcbe020f.1581955849.git.mchehab+huawei@kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 2020-02-17 at 17:11 +0100, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../filesystems/{ceph.txt => ceph.rst}        | 26 +++++++++++--------
>  Documentation/filesystems/index.rst           |  1 +
>  2 files changed, 16 insertions(+), 11 deletions(-)
>  rename Documentation/filesystems/{ceph.txt => ceph.rst} (91%)
> 

Looks fine to me. Mauro, should I merge this via the ceph tree, or are
you merging them in via some other tree? In any case:

Acked-by: Jeff Layton <jlayton@kernel.org>
