From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH v5 4/4] qemu/rbd: improve rbd device
 specification
Date: Wed, 16 Nov 2011 10:25:46 +0000
Message-ID: <20111116102546.GE25332@redhat.com>
References: <4EAEFED2.70808@redhat.com>
 <3bd8191e8040b4ebe95d31200373539be7ba6e95.1320110364.git.josh.durgin@dreamhost.com>
 <4EC2FE47.60501@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21590 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620Ab1KPKZz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Nov 2011 05:25:55 -0500
Content-Disposition: inline
In-Reply-To: <4EC2FE47.60501@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Tue, Nov 15, 2011 at 05:05:27PM -0700, Eric Blake wrote:
> On 10/31/2011 07:29 PM, Josh Durgin wrote:
> > From: Sage Weil <sage@newdream.net>
> > +        if (sec) {
> > +            char *base64 = NULL;
> > +
> > +            secret = (char *)conn->secretDriver->getValue(sec, &secret_size, 0,
> > +                                                          VIR_SECRET_GET_VALUE_INTERNAL_CALL);
> > +            if (secret == NULL) {
> > +                qemuReportError(VIR_ERR_INTERNAL_ERROR,
> > +                                _("could not get the value of the secret for username %s"),
> > +                                disk->auth.username);
> > +                goto error;
> > +            }
> > +            /* qemu/librbd wants it base64 encoded */
> > +            base64_encode_alloc(secret, secret_size, &base64);
> > +            if (!base64) {
> > +                virReportOOMError();
> > +                goto error;
> > +            }
> > +            virBufferEscape(opt, ":", ":key=%s:auth_supported=cephx none",
> > +                            base64);
> > +            VIR_FREE(base64);
> 
> The command line that we pass to qemu gets logged.  But what happens if
> the secret was marked as ephemeral - could we be violating the premise
> of not exposing passwords to too broad an audience?  Or are we already
> safe in that the log entries created by virCommand can only be exposed
> to users that already can get at the secret information by other means?
> 
> Maybe this means we should we be adding capabilities into virCommand to
> prevent the logging of the actual secret (whether base64-encoded or
> otherwise), and instead log an alternate string?  That is, should
> virCommand be tracking parallel argv arrays; the real array passed to
> exec() but never logged, and the alternate array (normally matching the
> real one, but which can differ in this particular case of passing an
> argument that contains a password)?

The passing of secrets on the command line is just a temporary hack
we're doing to prove the overall handling of passwords for Ceph. The
real plan is to set them via  monitor command in QEMU, but we're just
waiting for some QEMU work before changing libvirt todo that.


Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
