From: Wido den Hollander <wido@widodh.nl>
Subject: Re: enabling cephx by default
Date: Wed, 12 Sep 2012 16:55:06 +0200
Message-ID: <5050A24A.7090608@widodh.nl>
References: <alpine.DEB.2.00.1209111722100.2433@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:60884 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab2ILOzL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 10:55:11 -0400
In-Reply-To: <alpine.DEB.2.00.1209111722100.2433@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/12/2012 02:25 AM, Sage Weil wrote:
> The next stable release will have cephx authentication enabled by default.
> We will probably do it in the next development release (v0.53) to work out
> any upgrade kinks well before that.  The process for setting up teh
> authentication keys on an existing cluster is at
>
> 	http://ceph.com/docs/master/cluster-ops/authentication/
>
> This needs a few eyeballs to make sure the upgrade process makes sense...
>

"Generate a secret key for every OSD, where {$id} is the OSD number:"

Where does {$id} come from? I know it's just a variable which the users 
needs to fill in, but it could be somewhat confusing.

You could do:

for id in {0..10}; do
ceph auth get-or-create osd.${id} mon 'allow rwx' osd 'allow *' -o 
/var/lib/ceph/osd/ceph-${id}/keyring;
done

I know this doesn't work for the mds which uses alpha-numeric names, but 
imho the {$id} variable seems to come from nowhere.

Maybe an example to make it more clear, because later in the page $id is 
used without the brackets ( { & } )


Later on, this command won't work:
$ sudo ceph auth get-or-create client.admin mds 'allow' osd 'allow *' 
mon 'allow *' > /etc/ceph/keyring

The "ceph" command gets executed as root, but the output won't, so 
writing to /etc/ceph/keyring will fail.

We could assume everybody executes these commands as root, but it might 
be somewhat confusing if one command has "sudo" prefixed and other 
don't. That might suggest it's somewhat special.

The same goes for a couple of commands after the one mentioned above.

I haven't tested the upgrade itself, but this is what I noticed while 
reading the docs.

Wido


> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

