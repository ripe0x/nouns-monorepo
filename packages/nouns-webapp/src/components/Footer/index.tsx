import classes from './Footer.module.css';
import { Container } from 'react-bootstrap';
import { buildEtherscanAddressLink } from '../../utils/etherscan';
// import { externalURL, ExternalURL } from '../../utils/externalURL';
import config from '../../config';
import Link from '../Link';
import { Trans } from '@lingui/macro';

const Footer = () => {
  // const twitterURL = externalURL(ExternalURL.twitter);
  const etherscanURL = buildEtherscanAddressLink(config.addresses.nounsToken);
  // const discourseURL = externalURL(ExternalURL.discourse);

  return (
    <div className={classes.wrapper}>
      <Container className={classes.container}>
        <footer className={classes.footerSignature}>
          {/* <Link text={<Trans>Twitter</Trans>} url={twitterURL} leavesPage={true} /> */}
          <Link text={<Trans>Etherscan</Trans>} url={etherscanURL} leavesPage={true} />
          <p style={{
            display: 'block',
            textAlign: 'center',
          }}>Nouns Fork 0 front-end client provided by <Link text="BuilderDAO" url="https://nouns.build/" leavesPage={true} /></p>
          {/* <Link text={<Trans>Forums</Trans>} url={discourseURL} leavesPage={false} /> */}
        </footer>
      </Container>
    </div>
  );
};
export default Footer;
